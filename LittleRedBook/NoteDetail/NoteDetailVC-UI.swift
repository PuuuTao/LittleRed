//
//  NoteDetailVC-UI.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/27.
//

import Foundation
import Kingfisher
import LeanCloud
import ImageSlideshow

extension NoteDetailVC{
    
    func setUI(){
        
        followBtn.makeCapsule(color: mainColor)
        
        dislikeBtn.makeCapsule(color: .quaternaryLabel)
        
        if isReadMyNote{
            followBtn.isHidden = true
            shareOrMoreBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        }
        
        showNote()
        showLike()
    }
    
    func showNote(isUpdatingNote: Bool = false){
        
        if !isUpdatingNote{
            let authorAvatarURL = author?.getImageURL(col: kAuthorCol, type: .avatar)
            authorAvatarBtn.kf.setImage(with: authorAvatarURL, for: .normal)
            authorNickNameBtn.setTitle(author?.getExactStringVal(col: kNickNameCol), for: .normal)
        }
        
        let noteTitle = note.getExactStringVal(col: kTitleCol)
        if noteTitle.isEmpty{
            titleLabel.isHidden = true
        }else{
            titleLabel.text = noteTitle
        }
        
        let noteText = note.getExactStringVal(col: kTextCol)
        if noteText.isEmpty{
            textLabel.isHidden = true
        }else{
            textLabel.text = noteText
        }
        
        let noteChannel = note.getExactStringVal(col: kChannelCol)
        let noteSubChannel = note.getExactStringVal(col: kSubChannelCol)
        topicBtn.setTitle(noteSubChannel.isEmpty ? noteChannel : noteSubChannel, for: .normal)
        
        if let updatedAt = note.updatedAt?.value{
            dateLabel.text = "\(note.getExactBoolVal(col: kHasEditCol) ? "编辑于 " : "")\(updatedAt.formattedDate)"
        }
        
        if let user = LCApplication.default.currentUser{
            let avatarURL = user.getImageURL(col: kAvatarCol, type: .avatar)
            avatarImageView.kf.setImage(with: avatarURL)
        }
        
        likeCount = note.getExactIntVal(col: kLikeCountCol)
        currentLikeCount = likeCount
        favCount = note.getExactIntVal(col: kFavCountCol)
        currentFavCount = favCount
        commentCount = note.getExactIntVal(col: kCommentCountCol)
        
        let coverPhotoHeight = CGFloat(note.getExactDoubleVal(col: kCoverPhotoRatioCol)) * screenRect.width
        imageSlideshowHeight.constant = coverPhotoHeight
        
        let coverPhoto = KingfisherSource(url: note.getImageURL(col: kCoverPhotoCol, type: .coverPhoto))
        if let photoPaths = note.get(kPhotosCol)?.arrayValue as? [String]{
            var photoArr = photoPaths.compactMap{ KingfisherSource(urlString: $0) }
            photoArr[0] = coverPhoto
            imageSlideshow.setImageInputs(photoArr)
        }else{
            imageSlideshow.setImageInputs([coverPhoto])
            //还有一种极少数的情况，就是没取到图片但是取到图片的宽高比了，所以建议我们做默认图的时候做一张无论怎么裁剪都差不多的图
            
        }
        
    }
    
    
    func showLike(){
        likeBtn.setSelected(selected: isLikeFromWaterfallCell, animated: false)
    }
    
}
