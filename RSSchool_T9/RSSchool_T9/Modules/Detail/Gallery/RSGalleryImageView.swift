//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSGalleryImageView: UIControl {
    
    var image: UIImage? {
        imageView.image
    }
    
    private let borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = nil
        layer.lineWidth = 1.0
        
        return layer
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 4.0
        
        return view
    }()

    convenience init(_ image: UIImage?) {
        self.init(frame: .zero)
        imageView.image = image
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

extension RSGalleryImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8.0).cgPath
    }
}

// MARK: -

private extension RSGalleryImageView {
    func setupAppearance() {
        layer.addSublayer(borderLayer)
        addSubview(imageView)
        
        imageView.bind(to: self, insets: UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
    }
}
