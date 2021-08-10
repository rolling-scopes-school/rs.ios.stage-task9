//
//  Helpers.swift
//  RSSchool_T9
//
//  Created by Uladzislau Volchyk on 24.07.21.
//

import UIKit

extension UIView {
    
    func bind(to view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    func bind(to guide: UILayoutGuide, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    class var reuseIdentifier: String {
        String(describing: self)
    }
    
    
    func isVisible(in view: UIView?) -> Bool {
        guard let inView = view else {
            return true
        }
        let viewFrame = inView.convert(bounds, from: self)
        if viewFrame.intersects(inView.bounds) {
            return isVisible(in: inView.superview)
        }
        return false
    }

}

extension UIFont {
    static func rockwell(size: CGFloat) -> UIFont? {
        UIFont(name: "Rockwell", size: size)
    }
}

extension UIColor {
    
    var hexString: String {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        
        return String(format:"#%06x", rgb)
    }
}

extension CGFloat {
    static var start: CGFloat {
        0.0
    }
    
    static var finish: CGFloat {
        1.0
    }
}
