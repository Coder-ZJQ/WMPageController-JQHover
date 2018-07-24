#
# Be sure to run `pod lib lint JQHoverPage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JQHoverPage'
  s.version          = '0.1.0'
  s.summary          = 'Extension of WMPageController, implement pages hover menu.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Extension of WMPageController, implement pages hover menu.
Same style as WMPageController. Painless to use.
                       DESC

  s.homepage         = 'https://github.com/Coder-ZJQ/WMPageController-JQHover'
  s.screenshots      = 'https://raw.githubusercontent.com/Coder-ZJQ/WMPageController-JQHover/master/Images/demo.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'coder-zjq' => 'zjq_joker@163.com' }
  s.source           = { :git => 'https://github.com/Coder-ZJQ/WMPageController-JQHover.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JQHoverPage/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JQHoverPage' => ['JQHoverPage/Assets/*.png']
  # }

  s.public_header_files = 'JQHoverPage/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'WMPageController'
end
