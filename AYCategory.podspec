#
# Be sure to run `pod lib lint AYCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AYCategory'
  s.version          = '1.0.16'
  s.summary          = 'Convenient categories.'

  s.homepage         = 'https://github.com/alan-yeh/AYCategory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alan Yeh' => 'alan@yerl.cn' }
  s.source           = { :git => 'https://github.com/alan-yeh/AYCategory.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'AYCategory/Classes/**/*'
  s.public_header_files = 'AYCategory/Classes/**/*.h'

  s.frameworks = 'UIKit'
  s.dependency 'AYRuntime'
end
