//
//  MeHeaderView.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/5.
//

import UIKit
import LeanCloud
import Kingfisher

class MeHeaderView: UIView {

    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var backOrSlideBtn: UIButton!
    @IBOutlet weak var changeBackgroundBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var likedAndFavedLabel: UILabel!
    @IBOutlet weak var editOrFollowBtn: UIButton!
    @IBOutlet weak var settingOrChatBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editOrFollowBtn.makeCapsule()
        settingOrChatBtn.makeCapsule()
    }
    
    var user: LCUser!{
        didSet{
            avatarImageView.kf.setImage(with: user.getImageURL(col: kAvatarCol, type: .avatar))
            nickNameLabel.text = user.getExactStringVal(col: kNickNameCol)
            
            let gender = user.getExactBoolVal(col: kGenderCol)
            
            genderLabel.text = gender ? "♂︎" : "♀︎"
            genderLabel.textColor = gender ? blueColor : mainColor
            idLabel.text = "\(user.getExactIntVal(col: kIDCol))"
            
            let intro = user.getExactStringVal(col: kIntroCol)
            introLabel.text = intro.isEmpty ? kIntroPH : intro
            
            guard let userObjectID = user.objectId?.stringValue else { return }
            let query = LCQuery(className: kUserInfoTable)
            query.whereKey(kUserObjectidCol, .equalTo(userObjectID))
            query.getFirst { res in
                if case let .success(object: userInfo) = res{
                    let likeCount = userInfo.getExactIntVal(col: kLikeCountCol)
                    let favCount = userInfo.getExactIntVal(col: kFavCountCol)
                    DispatchQueue.main.async {
                        self.likedAndFavedLabel.text = "\(likeCount + favCount)"
                    }
                }
            }
            
        }
    }

}
