//
//  LeanCloud-Extensions.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/25.
//

import Foundation
import LeanCloud

extension LCFile{
    
    func save(record: String, table: LCObject, group: DispatchGroup? = nil){
        group?.enter()
        self.save { result in
            switch result {
            case .success:
                if let value = self.url?.value {
                    print("文件保存完成。URL: \(value)")
                    
                    do {
                        try table.set(record, value: self)
                        group?.enter()
                        table.save { (result) in
                            switch result {
                            case .success:
                                break
                            case .failure(error: let error):
                                print("保存用户数据表失败，原因是：\(error)")
                            }
                            group?.leave()
                        }
                    } catch {
                        print("给字段赋值失败，原因是：\(error)")
                    }
                    
                }
            case .failure(error: let error):
                print("保存文件进云端失败，原因是：\(error)")
            }
            group?.leave()
        }
    }
    
    
}


extension LCObject{
    
    //取string类型
    func getExactStringVal(col: String) -> String { get(col)?.stringValue ?? "" }
    //取int类型
    func getExactIntVal(col: String) -> Int { get(col)?.intValue ?? 0 }
    //取double类型--这里默认值取1方便大多数情况使用
    func getExactDoubleVal(col: String) -> Double { get(col)?.doubleValue ?? 1 }
    //取bool类型--这里默认值取false，因为只有少数情况会使用，比如性别
    func getExactBoolVal(col: String) -> Bool { get(col)?.boolValue ?? false }
    func getExactBoolValDefaultTrue(col: String) -> Bool { get(col)?.boolValue ?? true }
    
    
    enum imageType{
        case avatar
        case coverPhoto
    }
    
    func getImageURL(col: String, type: imageType) -> URL{
        
        if let file = self.get(col) as? LCFile,
           let path = file.url?.stringValue,
           let url = URL(string: path){
            //解包成功
            return url
        }else{
            //解包失败，根据要取的图片类型的不同来分别返回不同的占位图
            switch type {
            case .avatar:
                return Bundle.main.url(forResource: "avatarPH1", withExtension: "jpeg")!
            case .coverPhoto:
                return Bundle.main.url(forResource: "imagePH", withExtension: "png")!
            }
        }
    }
    
    //用于给userInfor表中的数据递增使用
    static func userInfoIncrease(userObjectID: String, col: String){
        let query = LCQuery(className: kUserInfoTable)
        query.whereKey(kUserObjectidCol, .equalTo(userObjectID))
        query.getFirst { res in
            if case let .success(object: userInfo) = res{
                try? userInfo.increase(col)
                userInfo.save { _ in }
            }
        }
    }
    
    //用于给userInfo表中的数据减少的时候使用（取消点赞收藏等）
    static func userInfoDecrease(userObjectID: String, col: String, to: Int){
        let query = LCQuery(className: kUserInfoTable)
        query.whereKey(kUserObjectidCol, .equalTo(userObjectID))
        query.getFirst { res in
            if case let .success(object: userInfo) = res{
                try? userInfo.set(col, value: to)
                userInfo.save { _ in }
            }
        }
    }
    
}
