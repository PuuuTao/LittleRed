//
//  NoteDetailVC-DeleteReply.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/4.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    func deleteReply(reply: LCObject, indexPath: IndexPath){
        showDeleteAlert(name: "回复") { _ in
            reply.delete { _ in }
            try? self.note.increase(kCommentCountCol, by: -1)
            self.note.save { _ in }
            
            self.replies[indexPath.section].replies.remove(at: indexPath.row)
            
            self.tableView.reloadData()
            self.commentCount -= 1
        }
    }
    
}
