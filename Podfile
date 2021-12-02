# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LittleRedBook' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'XLPagerTabStrip', '~> 9.0'
pod 'CHTCollectionViewWaterfallLayout/Swift'
pod 'YPImagePicker'
pod 'MBProgressHUD', '~> 1.2.0'
pod 'SKPhotoBrowser'
pod 'KMPlaceholderTextView', '~> 1.4.0'
pod 'AMapLocation'
pod 'AMapSearch'
pod 'MJRefresh'
pod 'DateToolsSwift'
pod 'JVerification'
pod 'Alamofire', '~> 5.4'
pod 'AlipaySDK-iOS'
pod 'LeanCloud'
pod 'PopupDialog', '~> 1.1'
pod 'FaveButton'
pod 'ImageSlideshow', '~> 1.9.0'
pod 'Kingfisher', '~> 7.0'
pod "ImageSlideshow/Kingfisher"
pod 'GrowingTextView', '0.7.2'
pod 'SegementSlide', '3.0.1'
pod 'ActionSheetPicker-3.0'

  # Pods for LittleRedBook

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
