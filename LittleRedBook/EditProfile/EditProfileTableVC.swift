//
//  EditProfileTableVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/10.
//

import UIKit
import LeanCloud

class EditProfileTableVC: UITableViewController {
    
    var user: LCUser!
    var delegate: EditProfileTableVCDelegate?

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    var avatar: UIImage?{
        didSet{
            DispatchQueue.main.async {
                self.avatarImageView.image = self.avatar
            }
        }
    }
    
    var nickName = ""{
        didSet{
            nickNameLabel.text = nickName
        }
    }
    
    var gender = false{
        didSet{
            genderLabel.text = gender ? "男" : "女"
        }
    }
    
    var birth: Date?{
        didSet{
            if let birth = birth {
                birthLabel.text = birth.format(with: "yyyy-MM-dd")
            }else{
                birthLabel.text = "未填写"
            }
            
        }
    }
    
    var intro = ""{
        didSet{
            introLabel.text = intro.isEmpty ? "未填写" : intro
        }
    }
    
//    lazy var textField: UITextField = {
//        let textField = UITextField(frame: .zero)
//        return textField
//    }()
//
//    lazy var genderPickerView: UIStackView = {
//        let cancelBtn = UIButton()
//        setToolBarBtn(btn: cancelBtn, title: "取消", color: .secondaryLabel)
//        let doneBtn = UIButton()
//        setToolBarBtn(btn: doneBtn, title: "完成", color: mainColor)
//        let toolBarView = UIStackView(arrangedSubviews: [cancelBtn, doneBtn])
//        toolBarView.distribution = .equalSpacing
//
//        let pickerView = UIPickerView()
//        pickerView.dataSource = self
//        pickerView.delegate = self
//
//        let genderPickerView = UIStackView(arrangedSubviews: [toolBarView, pickerView])
//        genderPickerView.frame.size.height = 200
//        genderPickerView.axis = .vertical
//        genderPickerView.spacing = 8
//        genderPickerView.backgroundColor = .secondarySystemBackground
//
//        return genderPickerView
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
//        tableView.addSubview(textField)
//        textField.inputView = genderPickerView
    }

    @IBAction func back(_ sender: Any) {
        delegate?.updateUser(avatar: avatar, nickName: nickName, gender: gender, birth: birth, intro: intro)
        dismiss(animated: true)
    }
    
    
//    func setToolBarBtn(btn: UIButton, title: String, color: UIColor){
//        btn.setTitle(title, for: .normal)
//        btn.titleLabel?.font = .systemFont(ofSize: 14)
//        btn.setTitleColor(color, for: .normal)
//        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
//    }

}


//extension EditProfileTableVC: UIPickerViewDataSource, UIPickerViewDelegate{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        2
//    }
//
//func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        ["男","女"][row]
//    }
//
//}
