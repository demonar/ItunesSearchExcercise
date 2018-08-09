//
//  Utilities.swift
//
//
//  Created by DeMoN on 9/9/15.
//
//

import UIKit
import ReactiveCocoa

class Utilities {
    
    class func delay(_ delay:Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    class func async(_ closure: @escaping () -> Void) {
        DispatchQueue.global().async {
            closure()
        }
    }
    
    class func runOnMainThread(_ closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
    
    class func addSkipBackupAttributeToItemAtURL(_ filePath:String) -> Bool
    {
        let url = URL(fileURLWithPath: filePath)
        
        var success = false
        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try (url as NSURL).setResourceValue(true, forKey:URLResourceKey.isExcludedFromBackupKey)
                success = true
            } catch let error as NSError {
                success = false
                print("Error excluding \(url.lastPathComponent) from backup \(error)");
            }
        }
        return success
    }
    
    class func createRefreshControl(target: Any, selector: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: selector, for: .valueChanged)
        return refreshControl
    }
}

class BaseTextField : UITextField {
    
    @IBInspectable var textMargin: CGFloat = 0
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            if let placeholderText = self.placeholder {
                self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor:placeHolderColor!])
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor!.cgColor
        }
    }
    @IBInspectable var hasShadow: Bool = false {
        didSet{
            if self.hasShadow {
                let layer = self.layer
                layer.shadowColor = UIColor.lightGray.cgColor
                layer.shadowOffset = CGSize(width: 3, height: 3)
                layer.shadowOpacity = 0.2
                layer.masksToBounds = false
            }
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return bounds.insetBy(dx: textMargin, dy: textMargin)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
        return bounds.insetBy(dx: textMargin, dy: textMargin)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.insetBy(dx: textMargin, dy: textMargin)
    }
}

class BaseTextView: UITextView {
    var hintString: String?
    var hintLabel: UILabel = UILabel(frame: CGRect.zero)
    override var text: String! {
        didSet {
            self.hintLabel.isHidden = !text.trimSpaces().isEmpty
            super.text = text
        }
    }
    
    @IBInspectable var textMargin: CGFloat = 0 {
        didSet {
            self.textContainerInset = UIEdgeInsets(top: self.textMargin, left: self.textMargin, bottom: self.textMargin, right: self.textMargin)
        }
    }
    @IBInspectable var hintColor: UIColor = UIColor.lightGray {
        didSet {
            self.hintLabel.textColor = self.hintColor
        }
    }
    @IBInspectable var hint: String? {
        didSet {
            if hint != nil {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
                    self.configHint()
                }
            }
        }
    }
    
    func configHint() {
        self.hintString = hint
        self.hintLabel.translatesAutoresizingMaskIntoConstraints = false
        self.hintLabel.font = self.hintLabel.font.withSize(self.font!.pointSize)
        self.hintLabel.textColor = self.hintColor
        self.hintLabel.numberOfLines = 0
        self.hintLabel.text = self.hintString
        self.addSubview(self.hintLabel)
        
        let constraintH = NSLayoutConstraint.constraints(withVisualFormat: "|-margin-[hint]-margin-|", options: [], metrics: ["margin": self.textMargin != 0 ? self.textMargin + 3.0: 8.0], views: ["hint":self.hintLabel])
        let constraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-margin-[hint]-margin-|", options: [], metrics: ["margin": self.textMargin != 0 ? self.textMargin: 10.0], views: ["hint":self.hintLabel])
        self.addConstraints(constraintH)
        self.addConstraints(constraintV)
        self.hintLabel.preferredMaxLayoutWidth = self.frame.size.width
        self.hintLabel.isHidden = !self.text.trimSpaces().isEmpty
        self.reactive.continuousTextValues.take(during: self.reactive.lifetime).observeValues { [weak self] text in
            guard let this = self else { return }
            if let txt = text {
                this.hintLabel.isHidden = !txt.trimSpaces().isEmpty
            } else {
                this.hintLabel.isHidden = false
            }
        }
    }
    
    @IBInspectable var hasShadow: Bool = false {
        didSet{
            if self.hasShadow {
                let layer = self.layer
                layer.shadowColor = UIColor.lightGray.cgColor
                layer.shadowOffset = CGSize(width: 3, height: 3)
                layer.shadowOpacity = 0.2
                layer.masksToBounds = false
            }
        }
    }

}
