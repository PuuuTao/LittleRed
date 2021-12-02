//
//  NoteEditVC-Note.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/26.
//

import Foundation
import LeanCloud

extension NoteEditVC{
    
    func createNote(){
        
        do{
            let noteGroup = DispatchGroup()
            
            let note = LCObject(className: kNoteTable)
            
            //存视频
            if let videoURL = self.videoURL{
                let video = LCFile(payload: .fileURL(fileURL: videoURL))
                video.save(record: kVideoCol, table: note, group: noteGroup)
                
            }
            
            //存封面图
            if let coverPhotoData = photos[0].jpeg(jpegQuality: .high){
                let coverPhoto = LCFile(payload: .data(data: coverPhotoData))
                //coverPhoto.mimeType = "image/jpeg"
                coverPhoto.save(record: kCoverPhotoCol, table: note, group: noteGroup)
            }
            
            //把所有照片存到云端
            let photoGroup = DispatchGroup()
            var photoPaths: [Int: String] = [:]
            for (index, photo) in photos.enumerated(){
                if let photoData = photo.pngData(){
                    let photoFile = LCFile(payload: .data(data: photoData))
                    photoGroup.enter()
                    photoFile.save { res in
                        if case .success = res, let path = photoFile.url?.stringValue{
                            photoPaths[index] = path
                        }
                        photoGroup.leave()
                    }
                }
            }
            
            noteGroup.enter()
            photoGroup.notify(queue: .main) {
                let photoPathsArr = photoPaths.sorted(by: <).map{ $0.value }
                do{
                    try note.set(kPhotosCol, value: photoPathsArr)
                    note.save { _ in
                        noteGroup.leave()
                    }
                }catch{
                    print("照片字段赋值失败，原因是：\(error)")
                }
            }
            
            //向云端数据表中存一些简单数据
            try note.set(kTitleCol, value: titleTextField.exactText)
            try note.set(kTextCol, value: textView.exactText)
            try note.set(kChannelCol, value: channel.isEmpty ? "推荐" : channel)
            try note.set(kSubChannelCol, value: subChannel)
            try note.set(kPOINameCol, value: poiName)
            try note.set(kLikeCountCol, value: 0)
            try note.set(kFavCountCol, value: 0)
            try note.set(kCommentCountCol, value: 0)
            let coverPhotoSize = photos[0].size
            let coverPhotoRatio = Double(coverPhotoSize.height / coverPhotoSize.width)
            try note.set(kCoverPhotoRatioCol, value: coverPhotoRatio)
            
            try note.set(kAuthorCol, value: LCApplication.default.currentUser!)
            
            noteGroup.enter()
            note.save { res in
                noteGroup.leave()
            }
            
            noteGroup.notify(queue: .main) {
                self.showHUD(title: "发布笔记成功", isCurrentView: false)
            }
            
            if draftNote != nil{
                navigationController?.popViewController(animated: true)
            }else{
                dismiss(animated: true)
            }
            
            
        }catch{
            print("存笔记到云端失败，原因是：\(error)")
        }
        
    }
    
    
    func postDraftNote(draftNote: DraftNote){
        createNote()
        
        backgroundContext.perform {
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()
        }
        
        //UI
        DispatchQueue.main.async {
            self.postDraftNoteFinished?()
        }
        
    }
    
    
    func updateNote(note: LCObject){
        
        do{
            let noteGroup = DispatchGroup()
            
            if !isVideo{
                
                //存封面图
                if let coverPhotoData = photos[0].jpeg(jpegQuality: .high){
                    let coverPhoto = LCFile(payload: .data(data: coverPhotoData))
                    //coverPhoto.mimeType = "image/jpeg"
                    coverPhoto.save(record: kCoverPhotoCol, table: note, group: noteGroup)
                }
                
                //把所有照片存到云端
                let photoGroup = DispatchGroup()
                var photoPaths: [Int: String] = [:]
                for (index, photo) in photos.enumerated(){
                    if let photoData = photo.pngData(){
                        let photoFile = LCFile(payload: .data(data: photoData))
                        photoGroup.enter()
                        photoFile.save { res in
                            if case .success = res, let path = photoFile.url?.stringValue{
                                photoPaths[index] = path
                            }
                            photoGroup.leave()
                        }
                    }
                }
                
                noteGroup.enter()
                photoGroup.notify(queue: .main) {
                    let photoPathsArr = photoPaths.sorted(by: <).map{ $0.value }
                    do{
                        try note.set(kPhotosCol, value: photoPathsArr)
                        note.save { _ in
                            noteGroup.leave()
                        }
                    }catch{
                        print("照片字段赋值失败，原因是：\(error)")
                    }
                }
            }
            
            //向云端数据表中存一些简单数据
            try note.set(kTitleCol, value: titleTextField.exactText)
            try note.set(kTextCol, value: textView.exactText)
            try note.set(kChannelCol, value: channel.isEmpty ? "推荐" : channel)
            try note.set(kSubChannelCol, value: subChannel)
            try note.set(kPOINameCol, value: poiName)
            let coverPhotoSize = photos[0].size
            let coverPhotoRatio = Double(coverPhotoSize.height / coverPhotoSize.width)
            try note.set(kCoverPhotoRatioCol, value: coverPhotoRatio)
            try note.set(kHasEditCol, value: true)
            
            noteGroup.enter()
            note.save { res in
                noteGroup.leave()
            }
            
            noteGroup.notify(queue: .main) {
                self.updateNoteFinished?(note.objectId!.stringValue!)
                self.showHUD(title: "更新笔记成功", isCurrentView: false)
            }
            
            dismiss(animated: true)
            
        }catch{
            print("存笔记到云端失败，原因是：\(error)")
        }
        
        
    }
    
}

