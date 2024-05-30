# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'WeDivvy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeDivvy

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            end
        end
    end
end

ENV['SWIFT_VERSION'] = '5'

pod 'Firebase/Core'
pod 'Firebase/Crashlytics'
pod 'Firebase/Database'
pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Storage'
pod 'Firebase/Messaging'
pod 'Firebase/Firestore'
pod 'Firebase/Functions'
pod 'MRProgress'
pod 'InstantSearch'
pod 'InstantSearchClient'
pod 'SDWebImage'
pod 'Mixpanel'
pod 'GoogleSignIn'

end
