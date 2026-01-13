require_relative './node_modules/react-native/scripts/react_native_pods'


platform :ios, '16.0'
prepare_react_native_project!

target 'SwiftSuper' do
  use_frameworks! :linkage => :static
  
  # React Native Pods
  use_react_native!(
    :path => 'node_modules/react-native',
    :hermes_enabled => true,
    :fabric_enabled => true,
    :app_path => "#{Pod::Config.instance.installation_root}"
  )

  # Auto-link React Native modules (e.g., safe-area-context)
  config = use_native_modules!
  
  # Add other pods if needed
end

post_install do |installer|
  react_native_post_install(installer, "node_modules/react-native")
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
    end
  end
end
