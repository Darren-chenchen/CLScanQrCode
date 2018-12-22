//
//  ViewController.swift
//  CLScanQrCode
//
//  Created by darren on 2018/12/22.
//  Copyright © 2018年 haiding.123.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func clickBtn(_ sender: Any) {
        let vc = CLScanCodeController()
        vc.successClouse = {(result) in
            print(result)
            vc.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }
}

