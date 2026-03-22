//
//  PhotoSelector.swift
//  LoanPlus
//
//  Created by hao on 2024/11/29.
//


import UIKit
import AVFoundation

class PhotoSelector: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static func selectPhoto(finish: @escaping AnyBlock) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = shard
        imagePicker.allowsEditing = false
        
        shard.finishBlock = finish
        shard.imagePicker = imagePicker
        
        shard.showAlert()
    }
    
    private static let shard = PhotoSelector()
    
    private var finishBlock: AnyBlock?
    private var imagePicker: UIImagePickerController?
    
    func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        case .denied:
            completion(false)
            
        case .restricted:
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    
    func showSettingAlert() {
        let alert = UIAlertController(title: nil, message: "No se pudieron obtener los permisos de la cámara", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Abrir configuración", style: .default, handler: { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        Page.present(vc: alert, animated: true)
    }
    
    private func showAlert() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "camera", style: .default) { _ in
            self.checkCameraPermission(completion: { [weak self] res in
                if res {
                    DispatchQueue.main.async {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            self?.imagePicker?.sourceType = .camera
                            Page.present(vc: (self?.imagePicker)!, animated: true)
                        }
                    }
                    
                }else {
                    self?.showSettingAlert()
                }
            })
        }
        actionSheet.addAction(cameraAction)

        
        let photoAction = UIAlertAction(title: "photo", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker?.sourceType = .photoLibrary
                Page.present(vc: self.imagePicker!, animated: true)
            }
        }
        actionSheet.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        Page.present(vc: actionSheet, animated: true)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            finishBlock?(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
