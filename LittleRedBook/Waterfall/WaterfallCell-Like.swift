//
//  WaterfallCell-Like.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/29.
//

import Foundation
import LeanCloud

extension WaterfallCell{
    
    @objc func likeBtnTappedWhenLogin(){
        
        if likeCount != currentLikeCount{
            let user = LCApplication.default.currentUser!
            guard let note = note, let authorObjectID = (note.get(kAuthorCol) as? LCUser)?.objectId?.stringValue else { return }

            let offset = isLike ? 1 : -1
            currentLikeCount += offset
            
            if isLike{
                let userLike = LCObject(className: kUserLikeTable)
                try? userLike.set(kUserCol, value: user)
                try? userLike.set(kNoteCol, value: note)
                userLike.save { _ in }
                
                try? note.increase(kLikeCountCol)
                note.save { _ in }
                //try? author?.increase(kLikeCountCol)
                
                LCObject.userInfoIncrease(userObjectID: authorObjectID, col: kLikeCountCol)
                
            }else{
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                
                query.getFirst { res in
                    if case let .success(object: userLike) = res{
                        userLike.delete { _ in }
                    }
                }
                
                try? note.set(kLikeCountCol, value: likeCount)
                note.save { _ in }
                //try? author?.set(kLikeCountCol, value: likeCount)
                //author?.save { _ in }
                
                LCObject.userInfoDecrease(userObjectID: authorObjectID, col: kLikeCountCol, to: likeCount)
                
            }
        }
        
        
    }
    
}
