#
#  Be sure to run `pod spec lint VPNManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "VPNManager"
  s.version      = "0.0.1"
  s.summary      = "VPN Connection manager for IKEV2 and IPSec protocols"
  s.description  = "VPN Manager for IKEV2 and IPSec protocols . You can connect your VPN servers using this manager for iOS"
  s.homepage     = "https://github.com/barbayrak/VPNManager"
  s.license      = "MIT"
  s.author       = { "Kaan Baris BAYRAK" => "kaanbarisbayrak@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/barbayrak/VPNManager.git", :tag => "1.0.0" }
  s.source_files  = "VPNManager",'VPNManager/**/*.{h,m,c,swift}'
  s.public_header_files = 'VPNManager/**/*.h'
  s.frameworks = 'NetworkExtension', 'Foundation'
end
