# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

inhibit_all_warnings!

workspace ‘Budget.xcworkspace'

use_frameworks!

def common_pods
    
end

target ‘Budget’ do
    project ‘Budget/Budget.xcodeproj'
    
    pod 'R.swift', '~> 4.0.0'
    pod 'SwiftLint', '~> 0.24.2'
    pod 'IQKeyboardManagerSwift', '~> 5.0.7'
    pod 'ReactiveSwift', '~> 3.1.0'
    pod 'ReactiveCocoa', '~> 7.1.0'
    common_pods
end

target 'Domain' do
    project 'Domain/Domain.xcodeproj'
    
    common_pods
end

target 'Platform' do
    project 'Platform/Platform.xcodeproj'
    
    common_pods
end


