//
//  MeVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/25.
//

import UIKit
import LeanCloud
import SegementSlide

class MeVC: SegementSlideDefaultViewController {
    
    var user: LCUser
    
    lazy var meHeaderView = Bundle.loadNib(XIBName: "MeHeaderView", type: MeHeaderView.self)
    
    init?(coder: NSCoder, user: LCUser) {
        self.user = user
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var isFromNote = false
    var isMySelf = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setUI()
    }
    
    override var bouncesType: BouncesType { .child }
    
    override func segementSlideHeaderView() -> UIView? { setHeaderView() }
    
    override var titlesInSwitcher: [String] {
        return ["笔记", "收藏", "赞过"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        let isMyDraft = (index == 0) && isMySelf && (UserDefaults.standard.integer(forKey: kDraftNoteCount) > 0)
        let vc = storyboard!.instantiateViewController(withIdentifier: kWaterfallVCID) as! WaterfallVC
        vc.isMyDraft = isMyDraft
        vc.user = user
        vc.isMyNote = index == 0
        vc.isMyFav = index == 1
        vc.isMyLike = index == 2
        vc.isMyselfLike = (isMySelf && index == 2)
        vc.isFromMeVC = true
        vc.fromMeVCUser = user
        return vc
    }

    
    
    
    
    
    
    
    
    
//    @IBAction func logoutTest(_ sender: Any) {
//        LCUser.logOut()
//        let loginVC = storyboard!.instantiateViewController(withIdentifier: kLoginVCID)
//        loginAndMeParentVC.removeChildren()
//        loginAndMeParentVC.add(childVC: loginVC)
//    }
//
//
//
//    @IBAction func showDraftNotes(_ sender: Any) {
//
//        let navi = storyboard!.instantiateViewController(withIdentifier: kDraftNotesNaviID)
//        navi.modalPresentationStyle = .fullScreen
//        present(navi, animated: true)
//
//    }
//
    
    
}
