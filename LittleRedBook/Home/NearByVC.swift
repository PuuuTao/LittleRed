//
//  NearByVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/9/29.
//

import UIKit
import XLPagerTabStrip

class NearByVC: UIViewController, IndicatorInfoProvider{
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("NearBy", comment: "顶部附近标签"))
    }

    

}
