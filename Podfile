# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'LandmarkRemark' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for LandmarkRemark
  pod 'SwiftLint', '~> 0.32.0'
  
  # Firebase
  pod 'Firebase/Core', :inhibit_warnings => true
  pod 'Firebase/Database', :inhibit_warnings => true
  pod 'Firebase/Auth', :inhibit_warnings => true

  target 'LandmarkRemarkTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LandmarkRemarkUITests' do
    ## WARNING: Make sure you comment out inherit! :search_paths or face this
    ## deadly error
    ## see https://github.com/firebase/firebase-ios-sdk/issues/2294
    ## # inherit! :search_paths  # Make sure to comment out this in UITest target!
    # Pods for testing
  end

end
