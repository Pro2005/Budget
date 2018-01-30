# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

workspace ‘Budget.xcworkspace'

use_frameworks!

def common_pods
    
end

target ‘Budget’ do
    project ‘Budget/Budget.xcodeproj'
    
    pod 'R.swift', '~> 4.0.0'
    pod 'SwiftLint', '~> 0.24.2'
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


