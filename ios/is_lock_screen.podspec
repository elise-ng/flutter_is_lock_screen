#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint is_lock_screen.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'is_lock_screen'
  s.version          = '1.0.0'
  s.summary          = 'Detects if device is in lock screen.'
  s.description      = <<-DESC
Detects if device is in lock screen. Useful for determining whether app entered background due to locking screen or leaving app.
                       DESC
  s.homepage         = 'https://github.com/chihimng/flutter_is_lock_screen'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Chi Him Ng' => 'chihimng.io@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
