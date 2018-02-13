//
//  CoreDataStack.swift
//  Platform
//
//  Created by Illya on 2/13/18.
//  Copyright © 2018 Cleveroad. All rights reserved.
//

import Foundation
import CoreData
import ReactiveSwift
import Result

final class CoreDataStack {
    
    let context: NSManagedObjectContext
    private let persistentStoreCoordinator: NSPersistentStoreCoordinator
    private static let sharedInstance: CoreDataStack = {
        let inst = CoreDataStack()
        return inst
    }()
    private var didSetup: Bool = false
    
    static func shared() -> SignalProducer<CoreDataStack, AnyError> {
        return sharedInstance.setupIfNeeded()
    }
    
    private init() {
        guard let modelURL = Bundle.platform?.url(forResource: "Model", withExtension: "momd") else {
            fatalError()
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError()
        }
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
    }
    
    // MARK: Private
    
    private func setupIfNeeded() -> SignalProducer<CoreDataStack, AnyError> {
        guard !didSetup else {
            return SignalProducer(value: self)
        }
        return setup()
    }
    
    // MARK: Public
    
    func fetchAll<T: NSManagedObject>(typeEntity: T.Type, by predicate: NSPredicate? = nil) -> SignalProducer<[T], AnyError> {
        return SignalProducer {[unowned context = context] observer, lifetime in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: typeEntity))
            if let predicate = predicate {
                fetchRequest.predicate = predicate
            }
            var result: [T] = []
            do {
                result = try context.fetch(fetchRequest) as! [T]
            } catch {
                observer.send(error: .init(error))
            }
            observer.send(value: result)
            observer.sendCompleted()
        }
    }
    
    func count<T: NSManagedObject>(typeEntity: T.Type, by predicate: NSPredicate? = nil) -> SignalProducer<Int, AnyError> {
        return SignalProducer {[unowned context = context] observer, lifetime in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: typeEntity))
            if let predicate = predicate {
                fetchRequest.predicate = predicate
            }
            var result: Int = 0
            do {
                result = try context.count(for: fetchRequest)
            } catch {
                observer.send(error: .init(error))
            }
            observer.send(value: result)
            observer.sendCompleted()
        }
    }
    
    func save(block: @escaping (NSManagedObjectContext) -> Void) -> SignalProducer<Void, AnyError> {
        return privateManagedObjectContext()
            .flatMap(.concat, {[weak context = context] privateContext in
            return SignalProducer<Void, AnyError>{ observer, lifetime in
                privateContext.perform {
                    block(privateContext)
                    
                    guard let context = context else {
                        observer.sendInterrupted()
                        return
                    }
                    context.performAndWait {
                        do {
                            try context.save()
                        } catch {
                            observer.send(error: .init(error))
                        }
                        observer.send(value: ())
                        observer.sendCompleted()
                    }
                }
            }
        })
    }
    
    // MARK: Private
    
    private func setup() -> SignalProducer<CoreDataStack, AnyError> {
        guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError()
        }
        let storeURL = documentURL.appendingPathComponent("Model.sqlite")
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            return SignalProducer(error: .init(error))
        }
        didSetup = true
        return SignalProducer(value: self)
    }
    
    private func privateManagedObjectContext() -> SignalProducer<NSManagedObjectContext, AnyError> {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = context
        return SignalProducer(value: privateContext)
    }
    
}
