//
//  ViewController.swift
//  hello_camera
//
//  Created by willard on 16/9/4.
//  Copyright © 2016年 wilard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var opencvVersionLabel: UILabel!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCaptureStillImageOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    
    override func viewWillAppear(animated: Bool) {
        
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        for device in devices{
            
            if device.position == AVCaptureDevicePosition.Front{
                
                do{
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    if captureSession.canAddInput(input){
                        captureSession.addInput(input)
                        
                        sessionOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                        if captureSession.canAddOutput(sessionOutput){
                            
                            captureSession.addOutput(sessionOutput)
                            captureSession.startRunning()
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                            
                            cameraView.layer.addSublayer(previewLayer)
                            
                            previewLayer.position = CGPoint(x: self.cameraView.frame.width/2, y: self.cameraView.frame.height/2)
                            previewLayer.bounds = cameraView.frame
                            
                        }
                        
                    }
                    
                }
                catch{
                    print("error")
                }
                
            }
            
        }
        opencvVersionLabel.text = openCVWrapper.getOpenCVVersion()
    }


    @IBAction func takePhoto(sender: AnyObject) {
        if let videoconnetion = sessionOutput.connectionWithMediaType(AVMediaTypeVideo){
            sessionOutput.captureStillImageAsynchronouslyFromConnection(videoconnetion, completionHandler: {
                buffer, error in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData)!, nil, nil, nil)
            })
        }
    }
}

