#
# Be sure to run `pod lib lint ErrorHandler.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ErrorHandler'
  s.version          = '0.1.0'
  s.summary          = 'Flexible error handling for Swift and RxSwift'
  s.homepage         = 'https://github.com/ahmedAlmasri/ErrorHandler'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ahmad Almasri' => 'ahmed.almasri@ymail.com' }
  s.source           = { :git => 'https://github.com/ahmedAlmasri/ErrorHandler.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_versions = ['4.0', '4.1', '4.2', '5', '5.1', '5.2']
  s.subspec 'Core' do |core|
    core.source_files = 'ErrorHandler/Classes/Core/**/*'
  end
	s.subspec 'Rx' do |subspec|
    subspec.dependency 'ErrorHandler/Core'
	  subspec.dependency "RxCocoa"
	  subspec.dependency "RxSwift"
    subspec.platform     = :ios, '12.0'
    subspec.source_files = 'ErrorHandler/Classes/Rx/**/*'
  end
  s.default_subspec = 'Core'
end
