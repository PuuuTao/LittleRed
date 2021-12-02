//
//  Extensions.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/4.
//

import Foundation
import DateToolsSwift
import AVFoundation
import UIKit

//MARK: Bundle扩展
extension Bundle{
    var appName: String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    
    static func loadNib<T>(XIBName: String, type: T.Type) -> T{
        if let view = Bundle.main.loadNibNamed(XIBName, owner: nil, options: nil)?.first as? T{
            return view
        }
        fatalError("加载\(type)类型的view失败")
    }
    
}


//MARK: UIView扩展
extension UIView{
    @IBInspectable
    var ridus: CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
}


//MARK: UIViewController扩展
extension UIViewController{
    func showHUD(title: String, subTitle: String? = nil, isCurrentView: Bool = true){
        var viewToShow = view!
        if !isCurrentView{
            viewToShow = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: viewToShow, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func showHUD(title: String, view: UIView,subTitle: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func showLoadHUD(title: String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
    }
    func hideLoadHUD(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    
    func hideKeyboardWhenTappedAround(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func add(childVC: UIViewController){
        addChild(childVC)
        childVC.view.frame = view.bounds
        view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    func remove(childVC: UIViewController){
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
    func removeChildren(){
        if !children.isEmpty{
            for vc in children{
                remove(childVC: vc)
            }
        }
    }
     
}


//MARK: UItextField扩展
extension UITextField{
    var unwrappedText: String{ text ?? "" }
    
    var exactText: String{
        unwrappedText.isBlank ? "" : unwrappedText
    }
    
    var isBlank: Bool { unwrappedText.isBlank }
}

//MARK: UITextView扩展
extension UITextView{
    var unwrappedText: String{ text ?? "" }
    
    var exactText: String{
        unwrappedText.isBlank ? "" : unwrappedText
    }
    
    var isBlank: Bool { unwrappedText.isBlank }
}


//MARK: 可选型String扩展
extension Optional where Wrapped == String{
    var unwrappedText: String{ self ?? "" }
}


//MARK: 非可选型String扩展
extension String{
    var isBlank: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var isPhoneNum: Bool{
        Int(self) != nil && NSRegularExpression(kPhoneRegEx).matches(self)
    }
    var isAuthCode: Bool{
        Int(self) != nil && NSRegularExpression(kAuthCodeRegEx).matches(self)
    }
    var isPassword: Bool { NSRegularExpression(kPasswordRegEX).matches(self) }
    
    static func randomString(length: Int) -> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func spliceAttrStr(dateStr: String) -> NSMutableAttributedString{
     
        let attrText = toAttrStr()
        let attrDate = " \(dateStr)".toAttrStr(fontSize: 12, color: .secondaryLabel)
        
        attrText.append(attrDate)
        return attrText
    }
    
    func toAttrStr(fontSize: CGFloat = 14, color: UIColor = .label) -> NSMutableAttributedString{
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: color  
        ]
        return NSMutableAttributedString(string: self, attributes: attr)
    }
    
}
//MARK: 正则表达式判定
extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do{
            try self.init(pattern: pattern)
        }catch{
            fatalError("非法的正则表达式")
        }
    }
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}


//MARK: UIImageView扩展
extension UIImage{
    enum JPEGQuailty: CGFloat{
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
    
    func jpeg(jpegQuality: JPEGQuailty) -> Data?{
        jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    
    convenience init?(data: Data?){
        if let unwrappedData = data{
            self.init(data: unwrappedData)
        }else{
            return nil
        }
    }
}


//MARK: Date扩展
extension Date{
    var formattedDate: String{
        let currentYear = Date().year
        if year == currentYear{
            if isToday{
                if minutesAgo > 10{
                    return "今天 \(format(with: "HH:mm"))"
                }else{
                    return timeAgoSinceNow
                }
                
            }else if isYesterday{
                return "昨天 \(format(with: "HH:mm"))"
            }else{
                return format(with: "MM-dd")
            }
            
        }else if year < currentYear{
            return format(with: "yyyy-MM-dd")
            
        }else{
            return "来自未来的笔记，我们这个项目中没有这个需求"
        }
    }
}


//MARK: data转url扩展
extension FileManager{
    func save(data: Data?, dirName: String, fileName: String) -> URL?{
        guard let data = data else {
            print("要写入本地的data为nil")
            return nil
        }
        
        let dirURL = temporaryDirectory.appendingPathComponent(dirName, isDirectory: true)
        
        if !fileExists(atPath: dirURL.path){
            guard let _ = try? createDirectory(at: dirURL, withIntermediateDirectories: true) else {
                print("创建文件夹失败")
                return nil
            }
        }
        let fileURL = dirURL.appendingPathComponent(fileName)
        
        if !fileExists(atPath: fileURL.path){
            guard let _ = try? data.write(to: fileURL) else {
                print("写入文件失败")
                return nil
            }
        }
        
        return fileURL
        
    }
    
}


//MARK: URL
extension URL{
    
    var thumbnail: UIImage{
        
        let asset = AVAsset(url: self)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //assetImgGenerate.maximumSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        
        do{
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        }catch{
            return imagePH
        }
    }
}


//MARK: UIButton
extension UIButton{
    
    func setToDisabled(){
        isEnabled = false
        backgroundColor = mainLightColor
    }
    
    func setToEnabled(){
        isEnabled = true
        backgroundColor = mainColor
    }
    
    func makeCapsule(color: UIColor = .label){
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}


//MARK: 给int扩展（格式化点赞数，评论数和收藏数）
extension Int{
    var formattedStr: String{
        let num = Double(self)
        let tenThousand = num / 10_000
        let hundredMillion = num / 100_000_000
        
        if tenThousand < 1{
            return "\(self)"
        }else if hundredMillion > 1{
            return "\(round(hundredMillion * 10) / 10)亿"
        }else{
            return "\(round(tenThousand * 10) / 10)万"
        }
        
    }
    
}

//MARK: UIAlertAction
extension UIAlertAction{
    func setTitleColor(color: UIColor){
        setValue(color, forKey: "titleTextColor")
    }
    
    var titleTextColor: UIColor?{
        get{
            value(forKey: "titleTextColor") as? UIColor
        }
        set{
            setValue(newValue, forKey: "titleTextColor")
        }
    }
}

//MARK: UserDefault
extension UserDefaults{
    static func increase(key: String, val: Int = 1){
        standard.set(standard.integer(forKey: key) + val, forKey: key)
    }
    
    static func decrease(key: String, val: Int = 1){
        standard.set(standard.integer(forKey: key) - val, forKey: key)
    }
}
