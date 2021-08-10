//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSTypeView: UIView {

    private let borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        layer.fillColor = nil
        layer.strokeColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        
        return layer
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .rockwell(size: 24.0)
        view.text = "Story"

        view.textColor = .white
        
        return view
    }()
    
    var text: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
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

extension RSTypeView {
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8.0).cgPath
    }
}

// MARK: - Private interface

private extension RSTypeView {
    func setupAppearance() {
        addSubview(titleLabel)
        layer.addSublayer(borderLayer)
        
        backgroundColor = .black
        layer.cornerRadius = 8.0
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }
}
