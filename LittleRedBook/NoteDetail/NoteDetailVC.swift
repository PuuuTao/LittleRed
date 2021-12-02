//
//  NoteDetailVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/27.
//

import UIKit
import ImageSlideshow
import LeanCloud
import FaveButton
import GrowingTextView


class NoteDetailVC: UIViewController {
    
    var note: LCObject
    init?(coder: NSCoder, note: LCObject){
        self.note = note
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //顶部bar
    @IBOutlet weak var authorAvatarBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var shareOrMoreBtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    
    //tableHeaderView
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var imageSlideshowHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var topicBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //整个tableView
    @IBOutlet weak var tableView: UITableView!
    
    //下方bar
    @IBOutlet weak var likeBtn: FaveButton!
    @IBOutlet weak var likedCountLabel: UILabel!
    @IBOutlet weak var favBtn: FaveButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var commentCountBtn: UIButton!
    
    //评论框
    @IBOutlet weak var textViewBarView: UIView!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var textViewBarBottomConstraints: NSLayoutConstraint!
    
    lazy var overlayView: UIView = {
        let overlayView = UIView(frame: view.frame)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        overlayView.addGestureRecognizer(tap)
        return overlayView
    }()
    
    var isLikeFromWaterfallCell = false
    var deleteNoteFinished: (() -> ())?
    
    var comments: [LCObject] = []
    var replies: [ExpandableReplies] = []
    
    var isReply = false
    
    var replyToUser: LCUser?
    
    var isFromMeVC = false
    var fromMeVCUser: LCUser?
    
    var commentSection = 0
    
    var likeCount = 0{
        didSet{
            likedCountLabel.text = likeCount == 0 ? "点赞" : likeCount.formattedStr
        }
    }
    var currentLikeCount = 0
    
    var favCount = 0{
        didSet{
            favCountLabel.text = favCount == 0 ? "收藏" : favCount.formattedStr
        }
    }
    var currentFavCount = 0
    
    var commentCount = 0{
        didSet{
            commentCountLabel.text = "\(commentCount)"
            commentCountBtn.setTitle(commentCount == 0 ? "评论" : commentCount.formattedStr, for: .normal)
        }
    }
    
    var author: LCUser? { note.get(kAuthorCol) as? LCUser }
    var isLike: Bool { likeBtn.isSelected }
    var isFav: Bool { favBtn.isSelected }
    var isReadMyNote: Bool {
        if let user = LCApplication.default.currentUser, let author = author, user == author{
            return true
        }else{
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        setUI()
        getComments()
        getFav()
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustTableViewHeight()
    }
    
    
    @IBAction func back(_ sender: Any) { dismiss(animated: true) }
    
    @IBAction func goToAuthorMeVC(_ sender: Any) { noteToMeVC(user: author) }
    
    @IBAction func like(_ sender: Any) { like() }
    
    @IBAction func fav(_ sender: Any) { fav() }
    
    @IBAction func shareOrMore(_ sender: Any) { shareOrMore() }
    
    @IBAction func comment(_ sender: Any) { comment() }
    
    @IBAction func postComment(_ sender: Any) {
        
        if !textView.isBlank{
            
            if !isReply{
                postComment()
            }else{
                postReply()
            }
            
            textView.resignFirstResponder()
            textView.text = ""
            replyToUser = nil
            
        }else{
            showHUD(title: "评论不能为空哦")
            textView.resignFirstResponder()
            replyToUser = nil
        }
        
        
    }
    
    
}
