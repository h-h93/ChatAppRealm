//
//  String+Ext.swift
//  MuzzApp
//
//  Created by hanif hussain on 03/04/2024.
//

import UIKit

@nonobjc extension UIViewController {
    // taken from stack overflow many years ago -
    // calculates how high the frame should be for a piece of text
    func estimatedFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    func presentMZAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = MZAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let title = "Something went wrong"
        let message = "We were unable to complete your request at this time. Please try again."
        let buttonTitle = "Ok"
        let alertVC = MZAlertVC(alertTitle: title,
                                message: message,
                                buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
