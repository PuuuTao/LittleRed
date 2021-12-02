//
//  HomeVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/9/29.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        //MARK: 设置bar和item的属性
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.selectedBarHeight = 3
        
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        settings.style.buttonBarItemLeftRightMargin = 0
        
        
        super.viewDidLoad()
        
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label

        }
        
        containerView.bounces = false

        
    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = storyboard!.instantiateViewController(withIdentifier: kFollowVCID)
        let nearByVC = storyboard!.instantiateViewController(withIdentifier: kNearByVCID)
        let discoveryVC = storyboard!.instantiateViewController(withIdentifier: kDiscoveryVCID)
        
        return [discoveryVC, followVC, nearByVC]
    }
  

}
