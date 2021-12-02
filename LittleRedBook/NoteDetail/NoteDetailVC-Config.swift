//
//  NoteDetailVC-Config.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/27.
//

import Foundation
import ImageSlideshow
import GrowingTextView
import LeanCloud

extension NoteDetailVC{
    
    func config(){
        
        imageSlideshow.zoomEnabled = true
        imageSlideshow.circular = false
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = mainColor
        pageControl.pageIndicatorTintColor = .systemGray
        
        imageSlideshow.pageIndicator = pageControl
        
        if LCApplication.default.currentUser == nil{
            likeBtn.setToNormal()
            favBtn.setToNormal()
        }
        
        textView.textContainerInset = UIEdgeInsets(top: 11.5, left: 16, bottom: 11.5, right: 16)
        textView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        tableView.register(UINib(nibName: "CommentView", bundle: nil), forHeaderFooterViewReuseIdentifier: kCommentViewID)
        tableView.register(CommentSectionFooterView.self, forHeaderFooterViewReuseIdentifier: kCommentSectionFooterViewID)
        
    }
    
    func adjustTableViewHeight(){

        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = tableHeaderView.frame
        
        if frame.height != height{
            frame.size.height = height
            tableHeaderView.frame = frame
        }
    }
    
}

extension NoteDetailVC: GrowingTextViewDelegate{
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

extension NoteDetailVC{

    @objc func keyboardWillChangeFrame(notification: Notification){
        
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            
            let keyboardHeight = screenRect.height - endFrame.origin.y
            if keyboardHeight > 0{
                view.insertSubview(overlayView, belowSubview: textViewBarView)
            }else{
                overlayView.removeFromSuperview()
                textViewBarView.isHidden = true
            }
            textViewBarBottomConstraints.constant = keyboardHeight
            view.layoutIfNeeded()
        }
    }
}

