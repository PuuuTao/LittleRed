//
//  NoteDetailVC-LoadData.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/2.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    func getComments(){
        
        showLoadHUD()
        
        let query = LCQuery(className: kCommentTable)
        query.whereKey(kNoteCol, .equalTo(note))
        query.whereKey(kUserCol, .included)
        query.whereKey(kCreatedAtCol, .descending)
        query.limit = kCommentsOffset
        
        query.find { res in
            self.hideLoadHUD()
            if case let .success(objects: comments) = res{
                self.comments = comments
                self.getReplies()
                
            }
        }
        
    }
    
    
    func getReplies(){
        
        var repliesDic: [Int: [LCObject]] = [:]
        let group = DispatchGroup()
        
        for (index,comment) in comments.enumerated(){
            if comment.getExactBoolValDefaultTrue(col: kHasReplyCol){
                group.enter()
                let query = LCQuery(className: kReplyTable)
                query.whereKey(kCommentCol, .equalTo(comment))
                query.whereKey(kUserCol, .included)
                query.whereKey(kReplyToUserCol, .included)
                query.whereKey(kCreatedAtCol, .descending)
                
                query.find { res in
                    if case let .success(objects: replies) = res{
                        if replies.isEmpty{
                            try? comment.set(kHasReplyCol, value: false)
                            comment.save { _ in }
                        }
                        repliesDic[index] = replies
                    }else{
                        repliesDic[index] = []
                    }
                    group.leave()
                }
            }else{
                repliesDic[index] = []
            }
            
        }
        
        group.notify(queue: .main) {
            self.replies = repliesDic.sorted{ $0.key < $1.key }.map{ ExpandableReplies(replies: $0.value) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func getFav(){
        if let user = LCApplication.default.currentUser{
            let query = LCQuery(className: kUserFavTable)
            query.whereKey(kUserCol, .equalTo(user))
            query.whereKey(kNoteCol, .equalTo(note))
            query.getFirst { res in
                if case .success = res{
                    DispatchQueue.main.async {
                        self.favBtn.setSelected(selected: true, animated: false)
                    }
                }
            }
        }
    }
}
