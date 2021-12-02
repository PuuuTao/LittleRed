//
//  MeVC-EditIntro.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/8.
//

import Foundation
import LeanCloud

extension MeVC{
    @objc func editIntro(){
        let vc = storyboard!.instantiateViewController(withIdentifier: kIntroVCID) as! IntroVC
        vc.intro = user.getExactStringVal(col: kIntroCol)
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension MeVC: IntroVCDelegate{
    func updateIntro(intro: String) {
        //UI
        meHeaderView.introLabel.text = intro.isEmpty ? kIntroPH : intro
        //云端
        try? user.set(kIntroCol, value: intro)
        user.save{ _ in }
    }
    
    
}
