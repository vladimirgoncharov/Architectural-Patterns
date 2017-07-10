source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.3'
inhibit_all_warnings!
use_frameworks!

def di
    
    pod 'Swinject'
    pod 'SwinjectStoryboard'

end

target 'CocoaMVC' do

    di

end

target 'CocoaMVCTests' do
    
    di
    
end

target 'CocoaMVCUITests' do
    
    di
    
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
        end
    end
end
