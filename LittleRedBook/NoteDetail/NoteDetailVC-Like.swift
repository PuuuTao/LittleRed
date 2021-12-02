//
//  NoteDetailVC-Like.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/29.
//

import Foundation
import LeanCloud

extension NoteDetailVC{
    
    //点赞相关操作
    func like(){
        
        if let _ = LCApplication.default.currentUser{

            //UI
            isLike ? (likeCount += 1) : (likeCount -= 1)
            
            //数据
            //防止用户暴力点击
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(likeBtnTappedWhenLogin), object: nil)
            perform(#selector(likeBtnTappedWhenLogin), with: nil, afterDelay: 1)
            
        }else{
            //未登录，显示提示框
            showHUD(title: "登录之后才可以点赞笔记哦")
        }
        
    }
    
    @objc func likeBtnTappedWhenLogin(){
        
        if likeCount != currentLikeCount{
            
            let user = LCApplication.default.currentUser!
            let authorObjectID = user.objectId?.stringValue ?? ""
            
            let offset = isLike ? 1 : -1
            currentLikeCount += offset
            
            if isLike{
                
                let userLike = LCObject(className: kUserLikeTable)
                try? userLike.set(kUserCol, value: user)
                try? userLike.set(kNoteCol, value: note)
                userLike.save { _ in }
                
                try? note.increase(kLikeCountCol)
                note.save { _ in }
                
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
               
                LCObject.userInfoDecrease(userObjectID: authorObjectID, col: kLikeCountCol, to: likeCount)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

