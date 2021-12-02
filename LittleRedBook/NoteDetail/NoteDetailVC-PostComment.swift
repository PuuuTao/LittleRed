//
//  NoteDetailVC-PostComment.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/3.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    func postComment(){
        let user = LCApplication.default.currentUser!
        do{
            let comment = LCObject(className: kCommentTable)
            try comment.set(kTextCol, value: textView.unwrappedText)
            try comment.set(kUserCol, value: user)
            try comment.set(kNoteCol, value: note)
            try comment.set(kHasReplyCol, value: false)
            comment.save { res in
                if case .success = res{
                    self.showHUD(title: "评论发表成功")
                }
            }
            
            try? note.increase(kCommentCountCol)
            note.save { _ in }
            
            comments.insert(comment, at: 0)
            
            tableView.performBatchUpdates {
                tableView.insertSections(IndexSet(integer: 0), with: .automatic)
            }
            commentCount += 1
            
        }catch{
            print("给comment表的字段赋值失败，原因是: \(error)")
        }
    }
    
}
