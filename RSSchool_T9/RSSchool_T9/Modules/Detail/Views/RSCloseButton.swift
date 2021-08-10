//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 26.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSCloseButton: UIButton {
    
    private let borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        layer.fillColor = nil
        layer.strokeColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        
        return layer
    }()
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) { [self] in
                imageView?.tintColor = isHighlighted ? .lightGray : .white
            }
        }
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }

}

// MARK: - UIView interface

extension RSCloseButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width / 2).cgPath
        layer.cornerRadius = bounds.width / 2
    }
}

// MARK: - Private interface

private extension RSCloseButton {
    func setupAppearance() {
        layer.addSublayer(borderLayer)
        setImage(UIImage(systemName: "xmark"), for: .normal)
        imageView?.tintColor = .white
    }
}
