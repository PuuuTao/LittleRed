//
//  NoteDetailVC-EditNote.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/1.
//

import Foundation
import LeanCloud
import Kingfisher

extension NoteDetailVC{
    
    func editNote(){
        
        var photos: [UIImage] = []
        
        //取封面图
        if let coverPhotoPath = (note.get(kCoverPhotoCol) as? LCFile)?.url?.stringValue,
           let coverPhoto = ImageCache.default.retrieveImageInMemoryCache(forKey: coverPhotoPath){
            photos.append(coverPhoto)
        }
        
        //取其他图片
        if let photoPaths = note.get(kPhotosCol) as? [String]{
            let otherPhotos = photoPaths.compactMap{ ImageCache.default.retrieveImageInMemoryCache(forKey: $0) }
            photos.append(contentsOf: otherPhotos)
        }
        
        //视频--省略
        
        let noteEditVC = storyboard!.instantiateViewController(withIdentifier: kNoteEditVCID) as! NoteEditVC
        noteEditVC.note = note
        noteEditVC.photos = photos
        noteEditVC.updateNoteFinished = { noteID in
            let query = LCQuery(className: kNoteTable)
            query.get(noteID){ res in
                if case let .success(object: note) = res{
                    self.note = note //数据
                    self.showNote(isUpdatingNote: true) //UI
                }
            }
            
        }
        present(noteEditVC, animated: true)
    }
    
}
