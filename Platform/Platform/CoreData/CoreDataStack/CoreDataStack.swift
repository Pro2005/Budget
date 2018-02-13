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
    
    private func setup() -> SignalProducer<CoreDataStack, AnyError> {
        guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError()
        }
        let storeURL = documentURL.appendingPathComponent("Model.sqlite")
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            return SignalProducer(error: error)
        }
        didSetup = true
        return SignalProducer(value: self)
    }
    
}

/*
 
 // MARK: Public
 

 didSetup = true
 return Promise<CoreDataStack>(value: self)
 }
 
 // MARK: Public
 
 func fetchAll<T: NSManagedObject>(typeEntity: T.Type, by predicate: NSPredicate? = nil) -> Promise<[T]> {
 return Promise {[weak self] fulfill, rejected in
 guard let `self` = self else {
 rejected(NSError.cancelledError())
 return
 }
 let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: typeEntity))
 if let predicate = predicate {
 fetchRequest.predicate = predicate
 }
 let result = try self.context.fetch(fetchRequest) as! [T]
 fulfill(result)
 }
 }
 
 func count<T: NSManagedObject>(typeEntity: T.Type, by predicate: NSPredicate? = nil) -> Promise<Int> {
 return Promise {[weak self] fulfill, rejected in
 guard let `self` = self else {
 rejected(NSError.cancelledError())
 return
 }
 let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: typeEntity))
 if let predicate = predicate {
 fetchRequest.predicate = predicate
 }
 let result = try self.context.count(for: fetchRequest)
 fulfill(result)
 }
 }
 
 func save(block: @escaping (NSManagedObjectContext) -> Void) -> Promise<Void> {
 return Promise {[weak self] fulfill, reject in
 guard let `self` = self else {
 reject(NSError.cancelledError())
 return
 }
 let privateContext = self.privateManagedObjectContext()
 privateContext.perform {
 block(privateContext)
 do {
 try privateContext.save()
 } catch {
 reject(error)
 }
 self.context.performAndWait {
 do {
 try self.context.save()
 } catch {
 reject(error)
 }
 fulfill(())
 }
 }
 
 }
 /*
 let privateContext = privateManagedObjectContext()
 let pendingPromise = Promise<()>.pending()
 privateContext.perform {[weak self] in
 guard let `self` = self else {
 pendingPromise.reject(NSError.cancelledError())
 return
 }
 block(privateContext)
 do {
 try privateContext.save()
 } catch {
 pendingPromise.reject(error)
 }
 self.context.performAndWait {
 do {
 try self.context.save()
 } catch {
 pendingPromise.reject(error)
 }
 
 pendingPromise.fulfill(())
 }
 }
 return pendingPromise.promise*/
 }
 
 // MARK: Private
 
 private func privateManagedObjectContext() -> NSManagedObjectContext {
 let localContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
 localContext.parent = context
 return localContext
 }
 
 }*/
