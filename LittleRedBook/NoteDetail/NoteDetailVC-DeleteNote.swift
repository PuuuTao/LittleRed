//
//  NoteDetailVC-DeleteNote.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/1.
//

import Foundation
import LeanCloud
import UIKit


extension NoteDetailVC{
    
    func deleteNote(){
        
        showDeleteAlert(name: "笔记") { _ in
            //数据
            self.deleteLCNote()
            //UI
            self.dismiss(animated: true) {
                self.deleteNoteFinished?()
            }
        }
        
    }
    
    func deleteLCNote(){
     
        note.delete { res in
            if case .success = res{
                self.showHUD(title: "笔记已删除")
            }
        }
        
    }
    
}
