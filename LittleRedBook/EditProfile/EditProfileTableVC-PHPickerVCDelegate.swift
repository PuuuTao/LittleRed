//
//  EditProfileTableVC-PHPickerVCDelegate.swift
//  LittleRedBook
//
//  Created by Kevin Wang on 2021/11/10.
//

import Foundation
import PhotosUI

extension EditProfileTableVC: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProviders = results.map(\.itemProvider)
        if let itemProvider = itemProviders.first, itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self, let image = image as? UIImage else { return }
                self.avatar = image
            }
        }
    }
    
    
}
