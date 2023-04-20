# Uncomment the next line to define a global platform for your project
iphoneos_deployment_target = '16.0'
platform :ios, iphoneos_deployment_target

target 'FlingoLingo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for FlingoLingo
  pod 'SwiftLint', '0.51.0'

end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      # to suppress xcode warnings at Pods project-file, overriding podspec's deployment target
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < iphoneos_deployment_target.to_f
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = iphoneos_deployment_target
      end
    end
  end
end
