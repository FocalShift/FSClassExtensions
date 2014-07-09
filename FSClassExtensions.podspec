#
# Be sure to run `pod lib lint FSClassExtensions.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FSClassExtensions"
  s.version          = "1.7.0"
  s.summary          = "FocalShift Objective-C Class Extensions"
  s.description      = <<-DESC
                        A set of useful helper routines, organized as a series of class extensions.
                       DESC
  s.homepage         = "https://github.com/FocalShift/FSClassExtensions"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Bennett Smith" => "bennett@focalshift.com" }
  s.source           = { :git => "https://github.com/FocalShift/FSClassExtensions.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/focalshift'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  # s.resources = 'Pod/Assets/*.png'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
