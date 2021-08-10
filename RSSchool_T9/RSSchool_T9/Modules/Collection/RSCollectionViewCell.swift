//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSCollectionViewCell: UICollectionViewCell {
    
    private let outerBorder: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = nil
        layer.borderWidth = 1.0
        
        return layer
    }()
    
    private let innerBorder: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = nil
        layer.borderWidth = 1.0
        
        return layer
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        
        view.sizeToFit()
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .rockwell(size: 16.0)
        view.textColor = UIColor.white
        view.lineBreakMode = .byTruncatingTail
        
        return view
    }()
    
    private let subtitleLabel: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .rockwell(size: 12.0)
        view.textColor = UIColor.lightGray
        
        return view
    }()
    
    private let gradientView: RSGradientView = {
        let view = RSGradientView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.applyColors(
            (.clear, 0.7),
            (.black, 1.0)
        )
        view.applyRadius(10.0)
        
        return view
    }()
    
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

extension RSCollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        outerBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: 18).cgPath
        innerBorder.path = UIBezierPath(roundedRect: bounds.insetBy(dx: 8, dy: 10), cornerRadius: 10).cgPath
    }
}

// MARK: - Public interface

extension RSCollectionViewCell {
    func configure(with type: ContentType) {
        switch type {
        case .gallery(let gallery):
            imageView.image = gallery.coverImage
            titleLabel.text = gallery.title
            subtitleLabel.text = gallery.type
        case .story(let story):
            imageView.image = story.coverImage
            titleLabel.text = story.title
            subtitleLabel.text = story.type
        }
    }
}

// MARK: - Private interface

private extension RSCollectionViewCell {
    func setupAppearance() {
        contentView.addSubview(imageView)
        contentView.addSubview(gradientView)
        contentView.layer.addSublayer(outerBorder)
        contentView.layer.addSublayer(innerBorder)
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40.0),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18.0),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3.0)
        ])
        
        imageView.bind(to: contentView, insets: UIEdgeInsets(top: 10.0, left: 8.0, bottom: -10.0, right: -8.0))
        gradientView.bind(to: imageView)
        
    }
}
