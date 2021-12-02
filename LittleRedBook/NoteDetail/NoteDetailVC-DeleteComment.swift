//
//  NoteDetailVC-DeleteComment.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/2.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    func deleteComment(comment: LCObject, section: Int){
        showDeleteAlert(name: "评论") { _ in
            //删除云端中的数据
            comment.delete { _ in }
            try? self.note.increase(kCommentCountCol, by: -1)
            self.note.save { _ in }
            
            //删除内存中的数据
            self.comments.remove(at: section)
            
            //UI
            self.tableView.reloadData()
            self.commentCount -= 1
        }
    }
    
}
