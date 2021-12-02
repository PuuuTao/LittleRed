//
//  Constants.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/9/29.
//

import UIKit

//MARK: StoryboardID
let kFollowVCID = "FollowVC"
let kNearByVCID = "NearByVC"
let kDiscoveryVCID = "DiscoveryVC"
let kWaterfallVCID = "WaterfallVC"
let kNoteEditVCID = "NoteEditVC"
let kChannelTableVCID = "ChannelTableVC"
let kLoginNaviID = "LoginNaviID"
let kLoginVCID = "LoginVC"
let kMeVCID = "MeVC"
let kDraftNotesNaviID = "DraftNotesNaviID"
let kNoteDetailVCID = "NoteDetailVC"
let kIntroVCID = "IntroVC"
let kEditProfileNaviID = "EditProfileNaviID"
let kSettingTableVCID = "SettingTableVC"

//MARK: CellID
let KWaterfallCellID = "WaterfallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"
let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterFallCellID = "DraftNoteWaterFallCellID"
let kCommentViewID = "CommentViewID" //评论的header
let kReplyCellID = "ReplyCellID" //评论的回复
let kCommentSectionFooterViewID = "CommentSectionFooterViewID"
let kMyDraftNoteWaterfallCellID = "MyDraftNoteWaterfallCellID"

//MARK: 资源文件相关
//主题色
let mainColor = UIColor(named: "main")!
let blueColor = UIColor(named: "blue")!
let mainLightColor = UIColor(named: "main-light")!
//加载失败显示图像
let imagePH = UIImage(named: "imagePH")!
//一键登录页面图片宽高
let kLogoImgWidth: CGFloat = 180
let kLogoImgHeight: CGFloat = 110

//MARK: CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let persistentContainer = appDelegate.persistentContainer
let context = persistentContainer.viewContext
let backgroundContext = persistentContainer.newBackgroundContext()

//MARK: 布局间距常量
let kWaterfallPadding: CGFloat = 4
let kDraftNoteWaterfallCellBottomViewHeight: CGFloat = 84
//云端取到的笔记下面的文本框的高度
let kWaterfallCellBottomViewHeight: CGFloat = 64

//MARK: UI布局
let screenRect = UIScreen.main.bounds

//MARK: 瀑布流布局title
let kChannels = ["推荐","旅行","娱乐","才艺","美妆","穿搭","美食","萌宠"]
//let kChannels = ["Recommend","Travel","Entertainment","Talent","Makeup","Wear","Food","Pets"]

//话题
let kAllSubChannels = [
    ["iphone13", "Apple Watch S7", "花5个小时修的图", "超好看的花"],
    ["魔都畅玩", "爬行西藏", "超美无边泳池"],
    ["棋魂超好看", "鱿鱼游戏"],
    ["练舞20年", "还在玩小提琴吗,我已经尤克里里了哦", "钢琴", "听说拳击能减肥", "这年头谁还没点绝活"],
    ["平价粉底", "最近很火的面霜"],
    ["极简穿搭", "明星同款穿搭"],
    ["格调西餐厅", "网红店打卡"],
    ["我的猫主子", "我的狗", "我的兔兔"]
]
//倒计时总时间
let kTotalTime = 60

//MARK: 业务需求
let kCameraZoomFactor: CGFloat = 5.0
let kMaxPhotoCount = 9
let kPhotoPerRow = 3
let kPhotoSpacing: CGFloat = 2.0

let kMaxNoteTitleCount = 20
let kMaxNoteTextCount = 1000

//个人页面个人简介最多可输入的字数
let kMaxIntroCount = 100
//个人页面个人简介占位符
let kIntroPH = "点击这里，填写简介。"

//高德
let kApiKey = "f8243592af4b9d17c896d893c65f7c51"
//未获取到POIName
let kNoPOIPH = "未知地点"
//检索POI类别
let kPOIType = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
//初始POI数组
let kPOIsInitArr = [["不显示位置", ""]]
//设置每一页展示数量
let kPOIsOffset = 20


//极光
let kJAppKey = "47cfad45d42deceb2acd802f"

//支付宝
let kAliPayAppID = "2021002188620491"
let kAliPayPID = "2088122690032744"
let kAlipayPrivateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5eAAZ/nOBqPP/YWjHqsCmVzjHexj6h+xyyQSxXpOitZhgyoTpxPU/BRNjeJ414vl2E1GO+50SuOoYxW8zGP0ILn23GTcq2Ofms4Ahe0CHAhAYX2I9Ljrmv96yir6Je2a7hmtKo4d1tcBnyyV/HQi/MMDs36loI1S2vV/08lU0SJMJFrV2MMRlC8Xc+b+OuXa/6kGG8Tun7OmcejDk5zQkGpsiXWdZB08oOJ1qQX/TF1FIlkx2jhkZDb+FbNiVcp9eGwSqnVKNePpf6Ym96TaF4Zq5lP6TXpeFnyprYRT3y48HBF8Yl8TQt/HWykA7vHO6mrfzg4U67PtbjZXQk6f9AgMBAAECggEBAKIc5dnSs5ut1jhvKGr+MY4zxwl164twq5hZZKS0ik86c4qG+k5rPgJrqVrU31Uyo+I1WKCmBdGLl/M2/8+mE+XG3VPh0nq9RVY9p82cMfbQMsla9j+L3Sg8padh5tG87zsSb026Snj0+MzAoHHPKwoSz0884JKJ704bkXhFKXycRe+OvWnDQEmLVO/6bp8A8FE+KkLhPCq9angA60cwgC6V6+zdJPXQo/mS7LDfY8Yl20J0XzHTnu2k78IYKNQQFT5dX1Q1zNfeCXE6E4+HlLuSWXgN56qF6j4j4eY3Nrcx5UCWmAYrbgnx6fCDAmDe/Cf0wOiRDSibxGTO5ICab/ECgYEA4J8n0oHd7OlnVaWss1Dy5uVrx5rM2ztxzc4ABV2E6qA2fU2/OjyAE0pdPBRYo4/HiGCiRiHyrYP+4xqWeXiF16ck/AtOkTdDCnbZVjLT1Mv+SPbshYa5ywcaM210n9z5rzwwTVQtrYHJGvmlxpwRnL8X7bWkK1T6vSuIKCq4APMCgYEA02Croh3PexjYH8uw8b4uB8XWGxqxa91JzTfN8ICXk++6BosybiqSTxLBqiUSi0K2532BE1666gMxFkSVXKUnFdbN2+z0jIq8JKW+uD8USkbcaiZxoYlI8wQ0Dv1h5ciI2W9uDJkDqVkNCDngzVY6Ln1NqLyILkqnlsKEV0mWb08CgYBbghtMFCIgIRo69yq7RrAeRrq476Sjb702NcUmamn619g7BhBwnjMjKLmA/1z5DVshgRS685uU+uA9DxjcVbBZIbvcfpK8cEH8olx6VGyeFZj7irTi1Pcd8j/HUcEgW3rQ2/lll3Sgae5O8gOKPQyjyenqqoQ+LvmTVYe7rWOW5wKBgHnaPJcUQEtiIxURQ0vYqohoj+jIFodr5eOby+hc+QSbKc4j6EqB2B4lXedLv8jwCKiiPQqBjZbhiCaiGshxnHqGfd3OV5u9ToCB29Qy6Ot4tg+rYc4RajBNuAT8JLdmRx2xkutIOkghwdWAKAu3LYsnSOGA7bBh8QKD1+7JySMZAoGAak3czFpPyJkXQ8GheY9gIpFL3R7JBt1jMaHzCGrcc2aCAigbo+Q0TsXrhqRC4hIxN/WoeWxIKXM+/dVRVC6vdDuTrpilVpkLLerILzAHb52L+bjykV225eAI3O5weFAtzny33yMTQiyh6pQxuZZTzsic2X7hFLUkOl7wNrUSw2c="
let kAppScheme = "LittleRedBook"

//UserDefault
//苹果登录
let kNameFromAppleID = "nameFromAppleID"
let kEmailFromAppleID = "emailFromAppleID"
//统计用户存在本地的草稿数量
let kDraftNoteCount = "draftNoteCount"
//存在本地的用于判断用户现在选择的是深色模式，还是浅色模式，还是跟随系统设置
let kUserInterfaceStyle = "userInterfaceStyle"

//LeanCloud
let kLCAppID = "3JmpQW7nr0KFLCn364IkkwdV-gzGzoHsz"
let kLCAppKey = "g4X6gdUNFRbimgYSoxeo9Y1y"
let kLCServerURL = "https://3jmpqw7n.lc-cn-n1-shared.com"

//判定手机号的正则表达式
let kPhoneRegEx = "^1\\d{10}$"
//判定验证码的正则表达式
let kAuthCodeRegEx = "^\\d{6}$"
//判断用户输入的密码是否符合要求的正则表达式
let kPasswordRegEX = "^[0-9a-zA-Z]{6-16}$"

//LeanCloud短信模版名字--需审核，待做
let kTemplateName = ""
//LeanCloud短信签名名字--需审核，待做
let kSignatureName = ""

//用户数据表
let kNickNameCol = "nickName"
let kAvatarCol = "avatar"
let kGenderCol = "gender"
let kIntroCol = "intro"
let kIDCol = "id"
let kBirthCol = "birth"
let kIsSetPasswordCol = "isSetPassword"

//云端数据表
let kNoteTable = "Note"
//用户点赞表--中间表
let kUserLikeTable = "userLike"
//用户收藏表--中间表
let kUserFavTable = "userFav"
//评论表
let kCommentTable = "Comment"
//评论回复表
let kReplyTable = "Reply"
//用户信息表--用于统计获赞或者收藏数
let kUserInfoTable = "UserInfo"

//所有数据表都有的数据，更新时间和创建时间
let kCreatedAtCol = "createdAt"
let kUpdatedAtCol = "updatedAt"

//Note表字段
let kCoverPhotoCol = "coverPhoto"
let kPhotosCol = "photos"
let kVideoCol = "video"
let kTitleCol = "title"
let kTextCol = "text"
let kChannelCol = "channel"
let kSubChannelCol = "subChannel"
let kPOINameCol = "poiName"
let kIsVideoCol = "isVideo"
let kLikeCountCol = "likeCount"
let kFavCountCol = "favCount"
let kCommentCountCol = "commentCount"
let kCoverPhotoRatioCol = "coverPhotoRatio"
let kAuthorCol = "author"
let kHasEditCol = "hasEdit"

//用户点赞表--中间表--字段
let kUserCol = "user"
let kNoteCol = "note"

//comment评论表字段
let kHasReplyCol = "hasReply"

//评论回复表字段
let kCommentCol = "comment"
let kReplyToUserCol = "replyToUser"

//userInfo表字段
let kUserObjectidCol = "userObjectid"
let kNoteCountCol = "noteCount"

//从云端取数据单次数量
let kNotesOffset = 20
//从云端取笔记单次数量
let kCommentsOffset = 20


//MARK: 全局函数
func largeIcon(iconName: String, iconColor: UIColor) -> UIImage{
    let config = UIImage.SymbolConfiguration(scale: .large)
    let icon = UIImage(systemName: iconName, withConfiguration: config)!
    
    return icon.withTintColor(iconColor)
}

func fontIcon(iconName: String, iconColor: UIColor, fontSize: CGFloat) -> UIImage{
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: fontSize))
    let icon = UIImage(systemName: iconName, withConfiguration: config)!
    
    return icon.withTintColor(iconColor)
}

func showGlobalTextHUD(title: String){
    let window = UIApplication.shared.windows.last!
    let hud = MBProgressHUD.showAdded(to: window, animated: true)
    hud.mode = .text
    hud.label.text = title
    hud.hide(animated: true, afterDelay: 2)
}
