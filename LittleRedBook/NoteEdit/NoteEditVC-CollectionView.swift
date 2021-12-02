//
//  NoteEditVC-CollectionView.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/10.
//

import Foundation
import YPImagePicker
import SKPhotoBrowser
import AVKit



extension NoteEditVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isVideo{
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL!)
            present(playerVC, animated: true) {
                playerVC.player?.play()
            }
        }else{
            var images: [SKPhoto] = []
            for photo in photos{
                images.append(SKPhoto.photoWithImage(photo))
            }
            
            let browser = SKPhotoBrowser(photos: images)
            browser.delegate = self
            browser.initializePageIndex(indexPath.item)
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            present(browser, animated: true)
            
        }
    }
}

extension NoteEditVC: SKPhotoBrowserDelegate{
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        photoCollectionview.reloadData()
        reload()
    }
}



extension NoteEditVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        cell.imageView.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            photoFooter.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            return photoFooter
        default:
            fatalError("Footer有问题")
        }
    }
}

extension NoteEditVC{
    @objc func addPhoto(){
        if photoCount < kMaxPhotoCount{
            var config = YPImagePickerConfiguration()
            
            //MARK: 基础配置
            config.albumName = Bundle.main.appName
            config.screens = [.library]
            
            //MARK: 相册配置
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount
            config.library.numberOfItemsInRow = kPhotoPerRow
            config.library.spacingBetweenItems = kPhotoSpacing
            config.library.preSelectItemOnMultipleSelection = false
            
            //MARK: 画廊配置
            config.gallery.hidesRemoveButton = false
            
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                for item in items{
                    if case let .photo(photo) = item{
                        
                        self.photos.append(photo.image)
                    }
                }
                self.photoCollectionview.reloadData()
                
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)

        }else{
            showHUD(title: "最多只可以选择\(kMaxPhotoCount)张照片哦")
        }
    }
}
