//
//  CommentView.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/2.
//

import UIKit
import LeanCloud
import Kingfisher

class CommentView: UITableViewHeaderFooterView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    var comment: LCObject?{
        didSet{
            
            guard let comment = comment else { return }
            if let user = comment.get(kUserCol) as? LCUser{
                avatarImageView.kf.setImage(with: user.getImageURL(col: kAvatarCol, type: .avatar))
                nickNameLabel.text = user.getExactStringVal(col: kNickNameCol)
            }
            
            let commentText = comment.getExactStringVal(col: kTextCol)
            let createdAt = comment.createdAt?.value
            let dateText = createdAt == nil ? "刚刚" : createdAt!.formattedDate
            commentTextLabel.attributedText = commentText.spliceAttrStr(dateStr: dateText)

            
            
        }
    }

}
