//
//  ViewController.swift
//  PopoverPresent
//
//  Created by App005 SYNERGY on 2019/9/3.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func tap(_ sender: UIButton) {
        let vc = UIViewController()
        // 背景色
        vc.view.backgroundColor = UIColor.yellow
        // 弹出视图样式
        vc.modalPresentationStyle = .popover
        // 弹出视图大小
        vc.preferredContentSize = CGSize(width: 300, height: 300)
        // 设置代理
        vc.popoverPresentationController?.delegate = self
        // 设置依托的视图
        vc.popoverPresentationController?.sourceView = sender
        // 弹出视图的尖头位置：参照视图底边中间位置
        vc.popoverPresentationController?.sourceRect = sender.bounds
        // 弹出视图的箭头方向
        vc.popoverPresentationController?.permittedArrowDirections = .any
        
        vc.popoverPresentationController?.popoverBackgroundViewClass = OwnPopoverBackgroundView.self
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ViewController : UIPopoverPresentationControllerDelegate {
   
    
    // Called on the delegate when the popover controller will dismiss the popover. Return NO to prevent the
    // dismissal of the view.
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    
    // Called on the delegate when the user has taken action to dismiss the popover. This is not called when the popover is dimissed programatically.
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("视图消失")
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
