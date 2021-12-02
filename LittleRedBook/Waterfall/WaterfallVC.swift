//
//  WaterfallVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/3.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip
import LeanCloud
import SegementSlide

class WaterfallVC: UICollectionViewController, SegementSlideContentScrollViewDelegate {
    
    var isDraft = false
    var isMyDraft = false
    
    lazy var header = MJRefreshNormalHeader()
    
    @objc var scrollView: UIScrollView { collectionView }
    
    var channel = ""
    var draftNotes: [DraftNote] = []
    
    var notes: [LCObject] = []
    
    var user: LCUser?
    var isMyNote = false
    var isMyFav = false
    var isMyLike = false
    
    var isMyselfLike = false
    
    var isFromMeVC = false
    var fromMeVCUser: LCUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()

        if let _ = user {
            //个人页面
            if isMyNote{
                header.setRefreshingTarget(self, refreshingAction: #selector(getMyNotes))
            }else if isMyFav{
                header.setRefreshingTarget(self, refreshingAction: #selector(getMyFavNotes))
            }else{
                header.setRefreshingTarget(self, refreshingAction: #selector(getMyLikeNotes))
            }
            
            header.beginRefreshing()
        }else if isDraft{
            //草稿页面
            getDraftNotes()
        }else{
            //首页
            header.setRefreshingTarget(self, refreshingAction: #selector(getNotes))
            header.beginRefreshing()
        }
        
    }

}




extension WaterfallVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString(channel, comment: "tab标签"))
    }
    
    
}
