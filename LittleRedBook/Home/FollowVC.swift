//
//  FollowVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/9/29.
//

import UIKit
import XLPagerTabStrip

class FollowVC: UIViewController, IndicatorInfoProvider{
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("Follow", comment: "顶部关注标签"))
    }
    

   

}
