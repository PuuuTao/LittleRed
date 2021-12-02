//
//  ReplyCell.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/3.
//

import UIKit
import LeanCloud
import Kingfisher

class ReplyCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var replyTextLabel: UILabel!
    @IBOutlet weak var showAllReplyBtn: UIButton!
    
    var reply: LCObject?{
        didSet{
            guard let reply = reply else { return }
            if let user = reply.get(kUserCol) as? LCUser{
                avatarImageView.kf.setImage(with: user.getImageURL(col: kAvatarCol, type: .avatar))
                nickNameLabel.text = user.getExactStringVal(col: kNickNameCol)
            }

            let createdAt = reply.createdAt?.value
            let dateText = createdAt == nil ? "刚刚" : createdAt!.formattedDate
            let replyText = reply.getExactStringVal(col: kTextCol).spliceAttrStr(dateStr: dateText)
            
            if let replyToUser = reply.get(kUserCol) as? LCUser{
                let replyToText = "回复 ".toAttrStr()
                let nickName = replyToUser.getExactStringVal(col: kNickNameCol).toAttrStr(fontSize: 14, color: .secondaryLabel)
                let colon = ": ".toAttrStr()
                
                replyToText.append(nickName)
                replyToText.append(colon)
                
                replyText.insert(replyToText, at: 0)
            }
            
            
            replyTextLabel.attributedText = replyText

            
            
        }
    }

}
