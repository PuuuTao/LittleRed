//
//  NoteEditVC-Helper.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/17.
//

import Foundation

extension NoteEditVC{
    
    func isValidateNote() -> Bool {
        
        guard !photos.isEmpty else {
            showHUD(title: "至少需要发布一张照片哦")
            return false
        }
        
        guard textViewIAView.currentCount <= kMaxNoteTextCount else {
            showHUD(title: "正文最多可输入\(kMaxNoteTextCount)字哦")
            return false
        }
        
        return true
    }
    
    
    func handleTFEditChanged(){
        
        guard titleTextField.markedTextRange == nil else {return}
        if titleTextField.unwrappedText.count > kMaxNoteTitleCount{
        
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            showHUD(title: "标题最多可输入\(kMaxNoteTitleCount)字哦～")
        
    }
    
        DispatchQueue.main.async {
            let end = self.titleTextField.endOfDocument
            self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
        }
        
        titleCountLabel.text = "\(kMaxNoteTitleCount - titleTextField.unwrappedText.count)"
 
    }
    
    
    
}
