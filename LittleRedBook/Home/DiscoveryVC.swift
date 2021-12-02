//
//  DiscoveryVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/9/29.
//

import UIKit
import XLPagerTabStrip

class DiscoveryVC: ButtonBarPagerTabStripViewController, IndicatorInfoProvider{
    

    override func viewDidLoad() {
        
        settings.style.selectedBarHeight = 0
        
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        
        super.viewDidLoad()

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label

        }
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("Discovery", comment: "顶部发现标签"))
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var vcs: [UIViewController] = []
        for channel in kChannels{
            let vc = storyboard!.instantiateViewController(withIdentifier: kWaterfallVCID) as! WaterfallVC
            vc.channel = channel
            vcs.append(vc)
        }
        return vcs
    }
    

   
}
