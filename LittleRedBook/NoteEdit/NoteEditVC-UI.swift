//
//  NoteEditVC-UI.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/17.
//

import Foundation
import PopupDialog

extension NoteEditVC{
    
    func setUI(){
        
        addPopup()
        setDraftNoteEditUI()
        setNoteEditUI()
        
    }
    
}


extension NoteEditVC{
    
    func setDraftNoteEditUI(){
        
        if let draftNote = draftNote{
            
            titleTextField.text = draftNote.title
            textView.text = draftNote.text
            channel = draftNote.channel!
            subChannel = draftNote.subChannel!
            poiName = draftNote.poiName!
            
            if !subChannel.isEmpty{
                updateChannelUI()
            }
            
            if !poiName.isEmpty{
                updatePOINameUI()
            }
        }
    }
    
    
    func setNoteEditUI(){
        
        if let note = note{
            
            titleTextField.text = note.getExactStringVal(col: kTitleCol)
            textView.text = note.getExactStringVal(col: kTextCol)
            channel = note.getExactStringVal(col: kChannelCol)
            subChannel = note.getExactStringVal(col: kSubChannelCol)
            poiName = note.getExactStringVal(col: kPOINameCol)
            
            if !subChannel.isEmpty{
                updateChannelUI()
            }
            
            if !poiName.isEmpty{
                updatePOINameUI()
            }
        }
    }
    
    
    func updateChannelUI(){
        
        channelLabel.text = subChannel
        channelIcon.tintColor = blueColor
        channelLabel.textColor = blueColor
        channelPlaceHolderLabel.isHidden = true
        
    }
    
    
    func updatePOINameUI(){
        
        if poiName == ""{
            poiNameLabel.text = "添加地点"
            poiNameLabel.textColor = .label
            poiNameIcon.tintColor = .label
        }else{
            poiNameLabel.text = poiName
            poiNameLabel.textColor = blueColor
            poiNameIcon.tintColor = blueColor
        }
        
    }
    
    
}


extension NoteEditVC{
    
    func addPopup(){
        let icon = largeIcon(iconName: "info.circle", iconColor: .secondaryLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(showPopup))
        
        //修改popup弹窗样式
        let popupView = PopupDialogDefaultView.appearance()
        popupView.titleColor = .label
        popupView.messageFont = .systemFont(ofSize: 13)
        popupView.messageColor = .secondaryLabel
        popupView.messageTextAlignment = .natural
        
        //修改popup弹窗里面的按钮的颜色
        let cancelBtnView = CancelButton.appearance()
        cancelBtnView.titleColor = .label
        //把按钮和上面文本之间的分割线的颜色改成主题色
        cancelBtnView.separatorColor = mainColor
        
        //修改popup弹窗的整体
        let popupContainerView = PopupDialogContainerView.appearance()
        popupContainerView.backgroundColor = .secondarySystemBackground
        popupContainerView.cornerRadius = 10
        
        
    }
    
}


extension NoteEditVC{
    @objc func showPopup(){
        
        let title = "发布小贴士"
        let message =
        """
        小粉书鼓励向上、真实、原创的内容，含以下内容的笔记将不会被推荐：
        1、含有不文明语言、过度性感图片；
        2、含有网址链接、联系方式、二维码或售卖语言；
        3、冒充他人身份或搬运他人作品；
        4、通过有奖方式诱导他人点赞、评论、收藏、转发、关注；
        5、为刻意博取眼球，在标题、封面等处使用夸张表达。
        """
        
        let popup = PopupDialog(title: title, message: message, transitionStyle: .zoomIn)
        
        let btn = CancelButton(title: "知道了", action: nil)
        popup.addButton(btn)
        
        present(popup, animated: true)
    }
}
