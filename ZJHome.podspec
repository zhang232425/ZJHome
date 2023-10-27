#
# Be sure to run `pod lib lint ZJHome.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    
  s.name             = 'ZJHome'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ZJHome.'
  s.homepage         = 'https://github.com/zhang232425/ZJHome'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhang232425' => '519301084@qq.com' }
  s.source           = { :git => 'https://github.com/zhang232425/ZJHome.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  
  s.source_files = 'ZJHome/Classes/**/*'
  
  s.resource_bundles = {
    'ZJHome' => ['ZJHome/Assets/**/*']
  }
  
  s.static_framework = true
  
  s.dependency 'Then'
  s.dependency 'Action'
  s.dependency 'RxCocoa'
  s.dependency 'RxSwift'
  s.dependency 'RxSwiftExt'
  s.dependency 'SnapKit'
  s.dependency 'SDCycleScrollView'
  s.dependency 'SwiftDate'
 
  s.dependency 'ZJRequest'
  s.dependency 'ZJLocalizable'
  s.dependency 'ZJRouter'
  s.dependency 'ZJRoutableTargets'
  s.dependency 'ZJBase'
  s.dependency 'ZJExtension'
  s.dependency 'ZJValidator'
  s.dependency 'ZJHUD'
  s.dependency 'ZJCommonView'
  s.dependency 'ZJRefresh'
  s.dependency 'ZJCommonDefines'
  s.dependency 'ZJLoginManager'
  
  
end
