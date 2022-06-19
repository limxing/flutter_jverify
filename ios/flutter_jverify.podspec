#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_jverify.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_jverify'
  s.version          = '0.0.1'
  s.summary          = '极光推送Flutter插件'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://bubupic.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { '李利锋' => 'lilifeng@bubupic.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  #s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'JCore', '3.2.3-noidfa'
  s.dependency 'JVerification', '2.7.9'
  s.platform = :ios, '9.0'
  #s.vendored_libraries = '**/*.a'
  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
