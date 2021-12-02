//
//  NoteEditVC.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/10/8.
//

import UIKit
import LeanCloud

class NoteEditVC: UIViewController {

    var photos: [UIImage] = []
    var videoURL: URL?
    
    var draftNote: DraftNote?
    var updateDraftNoteFinished: (() -> ())?
    var postDraftNoteFinished: (() -> ())?
    
    var note: LCObject?
    var updateNoteFinished: ((String) -> ())?
    
    var channel = ""
    var subChannel = ""
    var poiName = ""
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var photoCollectionview: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceHolderLabel: UILabel!
    @IBOutlet weak var poiNameIcon: UIImageView!
    @IBOutlet weak var poiNameLabel: UILabel!
    
    
    var photoCount: Int{ photos.count }
    var isVideo: Bool{ videoURL != nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        setUI()
    }
    
    var textViewIAView: TextViewIAView {textView.inputAccessoryView as! TextViewIAView}
    
    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    
    
    @IBAction func TFEditChanged(_ sender: Any) {
        handleTFEditChanged()
    }
    
    
    @IBAction func saveDraftNote(_ sender: Any) {
        
        guard isValidateNote() else { return }
        
        if let draftNote = draftNote{
            updateDraftNote(draftNote: draftNote)
        }else{
            createDraftNote()
        }
        
    }
    
    
    @IBAction func postNote(_ sender: Any) {
        
        guard isValidateNote() else { return }
        
        if let draftNote = draftNote {
            postDraftNote(draftNote: draftNote) //发布草稿笔记
        }else if let note = note{
            updateNote(note: note) //更新笔记
        }else{
            createNote() //发布新笔记
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC{
            channelVC.PVDelegate = self
        }else if let poiVC = segue.destination as? POIVC{
            poiVC.delegate = self
            poiVC.poiName = poiName
        }
    }
}

extension NoteEditVC: ChannelVCDelegate{
    func updateChannel(channel: String, subChannel: String) {
        self.channel = channel
        self.subChannel = subChannel
        
        updateChannelUI()
        
    }
    
}

extension NoteEditVC: POIVCDelegate{
    func updatePOIName(name: String) {
        if name == kPOIsInitArr[0][0]{
            poiName = ""
        }else{
            poiName = name
        }
        
        updatePOINameUI()
    }
}



extension NoteEditVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
}

extension NoteEditVC: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else {return}
        textViewIAView.currentCount = textView.text.count
    }
}

