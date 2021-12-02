//
//  DarkModeTableVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/12.
//

import UIKit

class DarkModeTableVC: UITableViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var followSystemSwitch: UISwitch!
    
    //获取当前用户的深浅色模式
    var userInterfaceStyle: UIUserInterfaceStyle { traitCollection.userInterfaceStyle }

    override func viewDidLoad() {
        super.viewDidLoad()

        darkModeSwitch.isOn = userInterfaceStyle == .dark
        followSystemSwitch.isOn = UserDefaults.standard.integer(forKey: kUserInterfaceStyle) == 0
    }

    
    @IBAction func toggle(_ sender: Any) {
        
        view.window?.overrideUserInterfaceStyle = darkModeSwitch.isOn ? .dark : .light
        
        followSystemSwitch.setOn(false, animated: true)
    }
    
    @IBAction func followSystem(_ sender: Any) {
        if followSystemSwitch.isOn{
            view.window?.overrideUserInterfaceStyle = .unspecified
            darkModeSwitch.setOn(userInterfaceStyle == .dark, animated: true)
        }else{
            view.window?.overrideUserInterfaceStyle = darkModeSwitch.isOn ? .dark : .light
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if followSystemSwitch.isOn{
            UserDefaults.standard.set(0, forKey: kUserInterfaceStyle)
        }else{
            UserDefaults.standard.set(darkModeSwitch.isOn ? 2 : 1, forKey: kUserInterfaceStyle)
        }
    }

}
