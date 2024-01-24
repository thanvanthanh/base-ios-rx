source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
inhibit_all_warnings!

target 'Base-ios' do
  use_frameworks!

 # Rx Extensions
  pod 'NSObject+Rx', '~> 5.0' # https://github.com/RxSwiftCommunity/NSObject-Rx
  pod 'RxCocoa'
  pod 'RxGesture'
  pod 'RxSwiftExt', '~> 5'
  pod 'Action'

  #Logger
  pod 'XCGLogger'
  
 # Networking
  pod 'Moya/RxSwift'

 # Animation
  pod 'lottie-ios'

 # UI
 pod 'SDWebImage'

 pod 'SwiftGen'
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
