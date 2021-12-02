//
//  NoteDetailVC-ShareOrMOre.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/1.
//

import Foundation
import UIKit

extension NoteDetailVC{
    
    func shareOrMore(){
        
        if isReadMyNote{
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let shareAction = UIAlertAction(title: "分享", style: .default) { _ in
                //分享功能
            }
            let editAction = UIAlertAction(title: "编辑", style: .default) { _ in
                //编辑功能
                self.editNote()
            }
            let deleteAction = UIAlertAction(title: "删除", style: .destructive) { _ in
                //删除功能
                self.deleteNote()
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel)
            
            alert.addAction(shareAction)
            alert.addAction(editAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
            
        }
        
    }
    
}
