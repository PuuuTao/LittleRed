//
//  TabBarController.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/4.
//

import UIKit
import YPImagePicker
import LeanCloud

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
}


extension TabBarController: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PostVC{
            
            if let _ = LCApplication.default.currentUser{
                
                var config = YPImagePickerConfiguration()
                
                //MARK: 基础配置
                config.isScrollToChangeModesEnabled = false
                config.onlySquareImagesFromCamera = false
                config.albumName = Bundle.main.appName
                config.startOnScreen = .library
                config.screens = [.library, .photo, .video]
                config.maxCameraZoomFactor = kCameraZoomFactor
                
                //MARK: 相册配置
                config.library.defaultMultipleSelection = true
                config.library.maxNumberOfItems = kMaxPhotoCount
                config.library.numberOfItemsInRow = kPhotoPerRow
                config.library.spacingBetweenItems = kPhotoSpacing
                config.library.preSelectItemOnMultipleSelection = false
                
                //MARK: 视频配置
                config.showsVideoTrimmer = false
                
                //MARK: 画廊配置
                config.gallery.hidesRemoveButton = false
                
                let picker = YPImagePicker(configuration: config)
                picker.didFinishPicking { [unowned picker] items, cancelled in
                    
                    if cancelled{
                        picker.dismiss(animated: true, completion: nil)
                    }else{
                        var photos: [UIImage] = []
                        var videoURL: URL?
                        
                        for item in items{
                            switch item{
                            case let .photo(photo):
                                photos.append(photo.image)
                            case .video:
                                let url = URL(fileURLWithPath: "recordedVideoRAW.mov", relativeTo: FileManager.default.temporaryDirectory)
                                photos.append(url.thumbnail)
                                videoURL = url
                            }
                        }
                        
                        let noteEditVC = self.storyboard!.instantiateViewController(withIdentifier: kNoteEditVCID) as! NoteEditVC
                        
                        noteEditVC.photos = photos
                        noteEditVC.videoURL = videoURL
                        picker.pushViewController(noteEditVC, animated: true)
                        
                    }
                    
                }
                present(picker, animated: true, completion: nil)
                
            }else{
                
                let alert = UIAlertController(title: "提示", message: "需要先登录哦", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "再看看", style: .cancel, handler: nil)
                let loginAction = UIAlertAction(title: "去登录", style: .default) { _ in
                    //跳转到登录页面
                    tabBarController.selectedIndex = 4
                }
                alert.addAction(cancelAction)
                alert.addAction(loginAction)
                
                present(alert, animated: true, completion: nil)
                
            }
            
            return false
        }
        
        return true
    }
    
}
