//
//  WaterfallCell.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/3.
//

import UIKit
import LeanCloud
import Kingfisher

class WaterfallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var isMyselfLike = false
    
    var likeCount = 0{
        didSet{
            likeBtn.setTitle(likeCount.formattedStr, for: .normal)
        }
    }
    var currentLikeCount = 0
    
    var isLike: Bool { likeBtn.isSelected }
    
    var note: LCObject?{
        didSet{
            guard let note = note, let author = note.get(kAuthorCol) as? LCUser else { return }
            
            //获取封面图url
            let coverPhotoURL = note.getImageURL(col: kCoverPhotoCol, type: .coverPhoto)
            imageview.kf.setImage(with: coverPhotoURL, options: [.transition(.fade(0.2))])
            
            //获取用户头像url
            let avatarURL = author.getImageURL(col: kAvatarCol, type: .avatar)
            avatarImageView.kf.setImage(with: avatarURL)
            
            titleLabel.text = note.getExactStringVal(col: kTitleCol)
            nickNameLabel.text = author.getExactStringVal(col: kNickNameCol)
            
            likeCount = note.getExactIntVal(col: kLikeCountCol)
            currentLikeCount = likeCount
            
            //判断用户是否已经点赞
            if !isMyselfLike{
                likeBtn.isSelected = true
            }else{
                if let user = LCApplication.default.currentUser{
                    
                    let query = LCQuery(className: kUserLikeTable)
                    query.whereKey(kUserCol, .equalTo(user))
                    query.whereKey(kNoteCol, .equalTo(note))
                    
                    query.getFirst { res in
                        if case .success = res{
                            DispatchQueue.main.async {
                                self.likeBtn.isSelected = true
                            }
                        }
                    }
                }
            }
            
            
        }
    }
    
    //设定点赞图标选中时的样式
    override func awakeFromNib() {
        super.awakeFromNib()
        let icon = UIImage(systemName: "heart.fill")?.withTintColor(mainColor, renderingMode: .alwaysOriginal)
        likeBtn.setImage(icon, for: .selected)
    }
    
    
    
    @IBAction func like(_ sender: Any) {
        
        if let _ = LCApplication.default.currentUser{
            
            //UI
            likeBtn.isSelected.toggle()
            isLike ? (likeCount += 1) : (likeCount -= 1)
            
            //数据
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(likeBtnTappedWhenLogin), object: nil)
            perform(#selector(likeBtnTappedWhenLogin), with: nil, afterDelay: 1)
            
        }else{
            
            showGlobalTextHUD(title: "登录之后才可以点赞笔记哦")
            
        }
        
    }
    
}
