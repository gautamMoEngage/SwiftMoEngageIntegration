# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'

use_frameworks!
target 'SwiftMoEngageIntegration' do

end

pod 'MoEngage-iOS-SDK'

target 'SwiftMoEngageIntegrationTests' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if target.name == “MoEngage-iOS-SDK"
        config.build_settings["OTHER_LDFLAGS"] = '$(inherited) "-ObjC"'
      end
    end
  end
end

