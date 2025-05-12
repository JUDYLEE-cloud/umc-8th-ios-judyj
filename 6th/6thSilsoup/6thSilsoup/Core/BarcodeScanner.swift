// 카메라 실행하고
// 바코드 찍으면 - 들어간 숫자 인식하고
// - 제거해서 api로 보내는 뷰

import Foundation
import AVFoundation
import SwiftUI

struct BarcodeScanner: UIViewControllerRepresentable {
    
    
    // Coordinator 클래스: AVCaptureMetadataOutputObjectsDelegate 채택
    // 바코드를 인식했을 때 호출
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScanner
        
        init(parent: BarcodeScanner) {
            self.parent = parent
        }
        
        // 바코드 인식했을 때 호출
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                // 바코드 데이터를 문자열로 변환함
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                
                // 스캔 완료시 진동
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                // - 제거
                let cleanedISBN = stringValue.replacingOccurrences(of: "-", with: "")
                
                // 결과를 상위뷰로 전달
                parent.didFindCode(cleanedISBN)
            }
        }
    }
    
    var didFindCode: (String) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()
        
        // 카메라 작동
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController}
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return viewController
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return viewController
        }
        
        // 바코드 감지를 위한 메타 데이터 출력 설정
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            // 델리게이트 지정 및 지원하는 바코드 타입
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .upce]
        } else {
            return viewController
        }
        
        // 카메라 화면을 표시할 미리보기 레이어 구성
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async{
            captureSession.startRunning()
        }
        
        return viewController
    }
    
    // 뷰 업데이트 시 호출. 지금은 필요 없음
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}
