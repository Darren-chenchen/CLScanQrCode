//
//  CLScanCodeController.swift
//  CLScanQrCode
//
//  Created by darren on 2018/12/22.
//  Copyright © 2018年 haiding.123.com. All rights reserved.
//

import UIKit

public typealias CLScanViewControllerSuccessClouse = (String?) -> ()
public typealias CLScanViewControllerFailClouse = () -> ()

open class CLScanCodeController: BMScanDefaultCotroller {

    open var successClouse: CLScanViewControllerSuccessClouse?
    open var failClouse: CLScanViewControllerFailClouse?

    open lazy var navView: IDScanNavgationView = {
        let nav = IDScanNavgationView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: KNavgationBarHeight))
        return nav
    }()
    // 返回按钮
    open lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.init(x: 0, y: UIDevice.current.isX() ? 44 : 20, width: 40, height: 40)
        
        btn.setImage(UIImage(named: "icn_back_white", in: BundleUtil.getCurrentBundle(), compatibleWith: nil), for: .normal)
        btn.addTarget(self, action: #selector(backBtnclick), for: .touchUpInside)
        return btn
    }()
    
    // 相册按钮
    open lazy var rightBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.init(x: KScreenWidth - 45, y: UIDevice.current.isX() ? 50 : 26, width: 35, height: 25)
        btn.setTitle("相册", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.titleLabel?.textAlignment = .right
        btn.addTarget(self, action: #selector(rightBtnClick), for: UIControl.Event.touchUpInside)
        return btn
    }()
    override open func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    override open func feetColor() -> UIColor! {
        return IDScanQrcodeConfig.shared.mainColor
    }
    open override func scanfLin() -> UIColor! {
        return IDScanQrcodeConfig.shared.mainColor
    }
    override open func areaWidth() -> CGFloat {
        return 240
    }
    open override func scanLin() -> BMScanLin {
        return .typeLin
    }
    override open func areaXHeight() -> CGFloat {
        return 240
    }
    override open func scanCapture(withValueString valueString: String?) {
        if self.successClouse != nil {
            self.successClouse!(valueString)
        }
    }
    
    func initView() {
        self.view.addSubview(self.navView)
        self.navView.addSubview(self.backBtn)
        self.navView.addSubview(self.rightBtn)
        
        self.navView.navLine.isHidden = true
        self.navView.backgroundColor = UIColor.black
    }
    
    //返回按钮事件
    @objc open func backBtnclick() {
        let VCArr = self.navigationController?.viewControllers
        if VCArr == nil {
            self.dismiss(animated: true, completion: nil)
            return
        }
        if VCArr!.count > 1 {
            self.navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //相册按钮事件
    @objc open func rightBtnClick() {
        //判断相册权限
        LimitsTools.share.authorizePhotoLibrary { (status) in
            if status == .authorized {
                //途径为相册
                let sourceType = UIImagePickerController.SourceType.photoLibrary
                //判断相册是否有故障
                if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
                    if self.failClouse != nil {
                        self.failClouse!()
                    }
                    return
                }
                
                let imagePickerVC = UIImagePickerController()
                imagePickerVC.delegate = self
                self.present(imagePickerVC, animated: true, completion: nil)
            }
        }
    }
}
extension CLScanCodeController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //选取照片后的回调方法
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 1.取出选中的图片
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        guard let ciImage = CIImage(image: image) else { return }
        // 2.从选中的图片中读取二维码数据
        // 2.1创建一个探测器
        // CIDetectorTypeFace -- 探测器还可以搞人脸识别
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        // 2.2利用探测器探测数据
        if let result = detector?.features(in: ciImage).first {
            let resultStr = (result as! CIQRCodeFeature).messageString ?? ""
            if resultStr.isEmpty {
                if self.failClouse != nil {
                    self.failClouse!()
                }
            } else {
                picker.dismiss(animated: true, completion: {
                    print(resultStr)
                    //跳转界面
                    if self.successClouse != nil {
                        self.successClouse!(resultStr)
                    }
                })
                return
            }
        } else {
            if self.failClouse != nil {
                self.failClouse!()
            }
        }
        
        // 注意: 如果实现了该方法, 当选中一张图片时系统就不会自动关闭相册控制器
        picker.dismiss(animated: true, completion: nil)
        
    }
}
