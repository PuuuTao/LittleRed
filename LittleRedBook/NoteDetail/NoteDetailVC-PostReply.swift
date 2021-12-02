//
//  NoteDetailVC-PostReply.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/3.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    func postReply(){
        let user = LCApplication.default.currentUser!
        do{
            let comment = comments[commentSection]
            //云端数据
            let reply = LCObject(className: kReplyTable)
            try reply.set(kTextCol, value: textView.unwrappedText)
            try reply.set(kUserCol, value: user)
            try reply.set(kCommentCol, value: comment)
            
            if let replyToUser = replyToUser{
                try reply.set(kReplyToUserCol, value: replyToUser)
            }
            
            reply.save { res in
                if case .success = res{
                    if let hasReply = comment.get(kHasReplyCol)?.boolValue, hasReply != true{
                        try? comment.set(kHasReplyCol, value: true)
                        comment.save { _ in }
                    }
                }
            }
            
            try? note.increase(kCommentCountCol)
            note.save { _ in }
            commentCount += 1
            
            //内存数据
            replies[commentSection].replies.append(reply)
            
            //UI
            if replies[commentSection].isExpanded{
                tableView.performBatchUpdates {
                    tableView.insertRows(at: [IndexPath(row: replies[commentSection].replies.count - 1, section: commentSection)], with: .automatic)
                }
            }else{
                let cell = tableView.cellForRow(at: IndexPath(row: 0, section: commentSection)) as! ReplyCell
                cell.showAllReplyBtn.setTitle("展开 \(replies[commentSection].replies.count - 1) 条评论", for: .normal)
            }
            
            
            
            
        }catch{
            print("给Reply表的字段赋值失败，原因是：\(error)")
        }
    }
    
}
