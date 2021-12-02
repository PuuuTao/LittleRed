//
//  NoteDetailVC-TableViewDelegate.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/2.
//

import Foundation
import LeanCloud

extension NoteDetailVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let commentView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentViewID) as! CommentView
        let comment = comments[section]
        commentView.comment = comment
        let commentAuthor = comment.get(kUserCol) as? LCUser
        
        if let commentAuthor = commentAuthor, let noteAuthor = author,commentAuthor == noteAuthor{
            commentView.authorLabel.isHidden = false
        }else{
            commentView.authorLabel.isHidden = true
        }
        
        let commentTap = UITapGestureRecognizer(target: self, action: #selector(commentTapped))
        commentView.tag = section
        commentView.addGestureRecognizer(commentTap)
        
        let avatarTap = UIPassableTapGestureRecognizer(target: self, action: #selector(goToMeVC))
        avatarTap.passObject = commentAuthor
        commentView.avatarImageView.addGestureRecognizer(avatarTap)
        
        let nickNameTap = UIPassableTapGestureRecognizer(target: self, action: #selector(goToMeVC))
        nickNameTap.passObject = commentAuthor
        commentView.nickNameLabel.addGestureRecognizer(nickNameTap)
        
        return commentView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separatorLine = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentSectionFooterViewID)
        return separatorLine
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = LCApplication.default.currentUser{
            let reply = replies[indexPath.section].replies[indexPath.row]
            guard let replyAuthor = reply.get(kUserCol) as? LCUser else { return }
            let replyAuthorNickName = replyAuthor.getExactStringVal(col: kNickNameCol)
            
            replyToUser = replyAuthor
            
            if user == replyAuthor{
                let replyText = reply.getExactStringVal(col: kTextCol)
                
                //弹出actionSheet
                let alert = UIAlertController(title: nil, message: "你的评论：\(replyText)", preferredStyle: .actionSheet)
                let replyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    //回复评论
                    self.prepareForReply(commentAuthorNickName: replyAuthorNickName, section: indexPath.section)
                }
                let copyAction = UIAlertAction(title: "复制", style: .default) { _ in
                    //复制功能--在ios中复制一个东西，就是把这个东西放到粘贴板中去
                    UIPasteboard.general.string = replyText
                }
                let deleteAction = UIAlertAction(title: "删除", style: .destructive) { _ in
                    //删除功能--同样要给用户一个确认框
                    self.deleteReply(reply: reply, indexPath: indexPath)
                }
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                
                alert.addAction(replyAction)
                alert.addAction(copyAction)
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                present(alert, animated: true)
                
            }else{
                prepareForReply(commentAuthorNickName: replyAuthorNickName, section: indexPath.section)
            }
            
        }else{
            showHUD(title: "请先登录哦")
        }
    }
    
}


extension NoteDetailVC{
    
    @objc func commentTapped(tap: UITapGestureRecognizer){
        
        if let user = LCApplication.default.currentUser{
            guard let section = tap.view?.tag else { return }
            let comment = comments[section]
            guard let commentAuthor = comment.get(kUserCol) as? LCUser else { return }
            let commentAuthorNickName = commentAuthor.getExactStringVal(col: kNickNameCol)
            if commentAuthor == user{
                let commentText = comment.getExactStringVal(col: kTextCol)
                //actionSheet
                let alert = UIAlertController(title: nil, message: "你的评论：\(commentText)", preferredStyle: .actionSheet)
                let replyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    //回复评论
                    self.prepareForReply(commentAuthorNickName: commentAuthorNickName, section: section)
                }
                let copyAction = UIAlertAction(title: "复制", style: .default) { _ in
                    //复制功能
                    UIPasteboard.general.string = commentText
                }
                let deleteAction = UIAlertAction(title: "删除", style: .destructive) { _ in
                    //删除功能
                    self.deleteComment(comment: comment, section: section)
                }
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                
                alert.addAction(replyAction)
                alert.addAction(copyAction)
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                present(alert, animated: true)
                
            }else{
                //评论框
                prepareForReply(commentAuthorNickName: commentAuthorNickName, section: section)
            }
            
        }else{
            showHUD(title: "请先登录哦")
        }
        
    }
    
}


extension NoteDetailVC{
    
    func prepareForReply(commentAuthorNickName: String, section: Int){
        isReply = true
        textView.placeholder = "回复 \(commentAuthorNickName)"
        textView.becomeFirstResponder()
        textViewBarView.isHidden = false
        
        commentSection = section
    }
    
}
