# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

workspace ‘Budget.xcworkspace'

use_frameworks!

def common_pods
    pod 'SwiftLint', '~> 0.24.2'
end

target ‘Budget’ do
    project ‘Budget/Budget.xcodeproj'
    
    pod 'R.swift', '~> 4.0.0'
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



#def common_pods
##    application_pods
##    platform_pods
#    pod 'SwiftLint', '~> 0.24.2'
#end
#
#
#def application_pods
#    pod 'R.swift', '~> 4.0.0'
#
#    domain_pods
#end
#
#def domain_pods
#    common_pods
#end
#
#def platform_pods
#    domain_pods
#
#end
#
#target ‘Budget’ do
#    project ‘Budget/Budget.xcodeproj'
#
#    application_pods
#end
#
#target 'Domain' do
#    project 'Domain/Domain.xcodeproj'
#
#    domain_pods
#end
#
#target 'Platform' do
#    project 'Platform/Platform.xcodeproj'
#
#    platform_pods
#end

#def common_pods
#    application_pods
#    platform_pods
#    pod 'SwiftLint', '~> 0.24.2'
#end


