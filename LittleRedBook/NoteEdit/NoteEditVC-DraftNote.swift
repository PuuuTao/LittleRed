//
//  NoteEditVC-DraftNote.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/17.
//

import Foundation


extension NoteEditVC{
    
    func createDraftNote(){
        
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            
            if self.isVideo{
                draftNote.video = try? Data(contentsOf: self.videoURL!)
            }
            draftNote.isVideo = self.isVideo
            
            self.handlePhotos(draftNote: draftNote)
            self.handleOthers(draftNote: draftNote)
            
            UserDefaults.increase(key: kDraftNoteCount)
            
            DispatchQueue.main.async {
                self.showHUD(title: "草稿保存成功", isCurrentView: false)
            }
            
        }
        
        dismiss(animated: true)
        
    }
    
    
    func updateDraftNote(draftNote: DraftNote){
        
        backgroundContext.perform {
            if !self.isVideo{
                self.handlePhotos(draftNote: draftNote)
            }
            self.handleOthers(draftNote: draftNote)
            
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}



extension NoteEditVC{
    
    func handlePhotos(draftNote: DraftNote){
        draftNote.coverPhoto = photos[0].jpeg(jpegQuality: .high)
        
        var photos: [Data] = []
        for photo in self.photos{
            if let pngData = photo.pngData(){
                photos.append(pngData)
            }
        }
        
        draftNote.photos = try? JSONEncoder().encode(photos)
        
    }
    
    
    func handleOthers(draftNote: DraftNote){
        
        DispatchQueue.main.async {
            draftNote.title = self.titleTextField.exactText
            draftNote.text = self.textView.exactText
        }
        
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updatedAt = Date()
        
        appDelegate.saveBackgroundContext()
        
    }
    
    
}
