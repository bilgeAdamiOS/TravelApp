//
//  CameraVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 20.08.2023.
//

import UIKit
import AVFoundation
import Photos
import TinyConstraints

class CameraVC: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    private lazy var btnTakePhoto:UIButton = {
        let captureButton = UIButton()
        
        captureButton.setTitle("Capture", for: .normal)
        captureButton.setTitleColor(.white, for: .normal)
        captureButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        return captureButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Capture Session oluştur
        captureSession = AVCaptureSession()
        
        // Kamerayı ayarla
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession?.addInput(input)
            
            capturePhotoOutput = AVCapturePhotoOutput()
            if let capturePhotoOutput = capturePhotoOutput, captureSession!.canAddOutput(capturePhotoOutput) {
                captureSession?.addOutput(capturePhotoOutput)
            }
        } catch {
            print(error)
            return
        }
        
        // Kameranın görüntüsünü preview olarak göster
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = .resizeAspect
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Capture Session'u başlat
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
        }
        
        self.view.addSubview(btnTakePhoto)
        
        btnTakePhoto.centerInSuperview()
        
    }
    
    
    
    // Fotoğraf çekme işlemi
    @objc func takePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        capturePhotoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    // Fotoğraf çekildiğinde çalışır
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            if let capturedImage = UIImage(data: imageData) {
                // Fotoğrafı galeriye kaydet
                UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
            }
        }
    }
}
