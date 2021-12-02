//
//  NoteDetailVC-TableViewDataSource.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/2.
//

import Foundation
import LeanCloud

extension NoteDetailVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let replyCount = replies[section].replies.count
        if replyCount > 1 && !replies[section].isExpanded{
            return 1
        }else{
            return replyCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReplyCellID, for: indexPath) as! ReplyCell
//        var content = cell.defaultContentConfiguration()
//        content.text = "我是评论的回复"
//        cell.contentConfiguration = content
        let reply = replies[indexPath.section].replies[indexPath.row]
        let replyAuthor = reply.get(kUserCol) as? LCUser
        cell.reply = reply
        
        if let replyAuthor = replyAuthor, let noteAuthor = author, replyAuthor == noteAuthor{
            cell.authorLabel.isHidden = false
        }else{
            cell.authorLabel.isHidden = true
        }
        
        let avatarTap = UIPassableTapGestureRecognizer(target: self, action: #selector(goToMeVC))
        avatarTap.passObject = replyAuthor
        cell.avatarImageView.addGestureRecognizer(avatarTap)
        
        let nickNameTap = UIPassableTapGestureRecognizer(target: self, action: #selector(goToMeVC))
        nickNameTap.passObject = replyAuthor
        cell.nickNameLabel.addGestureRecognizer(nickNameTap)
        
        let replyCount = replies[indexPath.section].replies.count
        if replyCount > 1, !replies[indexPath.section].isExpanded{
            cell.showAllReplyBtn.isHidden = false
            cell.showAllReplyBtn.setTitle("展开 \(replyCount - 1) 条回复", for: .normal)
            cell.showAllReplyBtn.tag = indexPath.section
            cell.showAllReplyBtn.addTarget(self, action: #selector(showAllReply), for: .touchUpInside)
        }else{
            cell.showAllReplyBtn.isHidden = true
        }
        
        return cell
    }
    
    
}


extension NoteDetailVC{
    @objc func showAllReply(sender: UIButton){
        let section = sender.tag
        replies[section].isExpanded = true
        tableView.performBatchUpdates {
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
        

    }
}
