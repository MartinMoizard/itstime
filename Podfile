platform :ios, '9.0'
use_frameworks!

target 'itstime' do
    pod 'RxSwift',    '~> 3.0.0-beta.1'
    pod 'RxCocoa',    '~> 3.0.0-beta.1'
    pod 'Alamofire',  '~> 4.0'
    pod 'AlamofireObjectMapper', '~> 4.0'
    pod 'Progressable', '~> 0.1.0'
    pod 'Action', '~> 2.0.0-beta.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
