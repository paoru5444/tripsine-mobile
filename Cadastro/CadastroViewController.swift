//
//  CadastroViewController.swift
//  tripsine-mobile
//
//  Created by Alex Rodrigues Pacheco on 06/06/22.
//

import UIKit

class CadastroViewController: UIViewController {
    
    let pickerController = UIImagePickerController()
    
    @IBOutlet var fotoPerfilImage: UIImageView!
    
    override func viewDidLoad() {
        pickerController.delegate = self
        super.viewDidLoad()
    }
    
    @IBAction func AddPhotoButton(_ sender: Any) {
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        
        present(pickerController, animated: true)
    }
}

extension CadastroViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.mediaType] as? UIImage {
            fotoPerfilImage.image = image
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

