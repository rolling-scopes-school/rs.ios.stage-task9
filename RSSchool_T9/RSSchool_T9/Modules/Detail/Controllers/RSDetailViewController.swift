//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSDetailViewController: UIViewController {

    private lazy var closeButton: RSCloseButton = {
        let view = RSCloseButton()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        view.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
        return view
    }()
    
    private let gradientView: RSGradientView = {
        let view = RSGradientView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.applyColors(
            (.clear, 0.5),
            (.black, 1.0)
        )
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
                
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "dog")
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = true
        
        
        return view
    }()
    
    private let typeView: RSTypeView = {
        let view = RSTypeView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: RSTitleLabel = {
        let view = RSTitleLabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .rockwell(size: 48.0)
        view.textColor = .white
        view.numberOfLines = 2
        view.lineBreakMode = .byClipping

        return view
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

}

// MARK: - UIViewController interface

extension RSDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }
}

// MARK: - Public interface

extension RSDetailViewController {
    func setup(image: UIImage, title: String, type: String) {
        imageView.image = image
        titleLabel.text = title
        typeView.text = type
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 58.0
        style.maximumLineHeight = 58.0
        
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [
            .paragraphStyle : style
        ])
        
        view.layoutIfNeeded()
    }
}

// MARK: - Private interface

private extension RSDetailViewController {
    func setupAppearance() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(closeButton)
        containerView.addSubview(imageView)
        containerView.addSubview(typeView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dividerView)
        containerView.addSubview(contentView)
        
        imageView.addSubview(gradientView)
        gradientView.bind(to: imageView)
        
        view.backgroundColor = .black
        
        scrollView.bind(to: view)
        containerView.bind(to: scrollView.contentLayoutGuide)

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30.0),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25.0),
            
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30.0),
            imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30.0),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30.0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.337),
            
            typeView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            typeView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 30.0),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -30.0),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -54.0),
            
            dividerView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.517),
            dividerView.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 40.0),
            dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1.0),
            
            contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 40.0),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20.0)
        ])
    }
    
    @objc func dismissAction() {
        dismiss(animated: true)
    }
}
