//
//  Extensions.swift
//
//
//  Created by DeMoN on 9/12/15.
//  
//

import UIKit


extension UIView {
    
    func scrollToY(_ y: CGFloat) {
        scrollToY(y, velocity: 0.25)
    }
    
    func scrollToView(_ view: UIView) {
        scrollToView(view, velocity: 0.25)
    }
    
    func scrollElement(_ view: UIView, toPoint y: CGFloat) {
        scrollElement(view, toPoint: y, velocity: 0.25)
    }
    
    func scrollToY(_ y: CGFloat, velocity: TimeInterval) {
        UIView.animate(withDuration: velocity, animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: 0, y: y)
        })
    }
    
    func scrollToView(_ view: UIView, velocity: TimeInterval) {
        let theFrame = view.frame
        var y : CGFloat = theFrame.origin.y - 15
        y -= (y/1.7)
        self.scrollToY(-y, velocity: velocity)
    }
    
    func scrollElement(_ view: UIView, toPoint y: CGFloat, velocity: TimeInterval) {
        let originY = view.frame.origin.y
        let diff = y - originY
        if (diff < 0) {
            self.scrollToY(diff, velocity: velocity)
        }
        else {
            self.scrollToY(0, velocity: velocity)
        }
    }
    
    func add(subView: UIView, With margin: UIEdgeInsets = .zero) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)
        self.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: margin.left).isActive = true
        self.topAnchor.constraint(equalTo: subView.topAnchor, constant: margin.top).isActive = true
        self.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: margin.right).isActive = true
        self.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: margin.bottom).isActive = true
    }
    
    class func autoLayout() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    @IBOutlet var nextField: UIResponder? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UIResponder
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UITextView {
    @IBOutlet var nextField: UIResponder? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UIResponder
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension IndexPath {
    static func indexPathsForRows(_ rows: [Int], inSection section: Int) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        for row in rows {
            indexPaths.append(IndexPath(row: row, section: section))
        }
        return indexPaths
    }
}

extension Date {
    func coolDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.MM.yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func minutesFromNow() -> Int { return self.timeFrom(60) }
    
    func hoursFromNow() -> Int { return self.timeFrom(3600) }
    
    func daysFromNow() -> Int { return self.timeFrom(86400) }
    
    func weeksFromNow() -> Int { return self.timeFrom(648000) }
    
    func monthsFromNow() -> Int { return self.timeFrom(2592000) }
    
    func yearsFromNow() -> Int { return self.timeFrom(31536000) }
    
    func timeFrom(_ timeUnit: Double) -> Int {
        return Int(self.timeIntervalSinceNow / timeUnit) * (self.timeIntervalSinceNow < 0 ? -1 : 1)
    }
    
    func shortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }
    
    func shortServerDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func trimSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

extension NSNumber {
    var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

extension UIViewAnimationOptions {
    init(curve: UIViewAnimationCurve) {
        switch curve {
        case .easeIn:
            self = .curveEaseIn
        case .easeOut:
            self = .curveEaseOut
        case .easeInOut:
            self = .curveEaseInOut
        case .linear:
            self = .curveLinear
        }
    }
}
