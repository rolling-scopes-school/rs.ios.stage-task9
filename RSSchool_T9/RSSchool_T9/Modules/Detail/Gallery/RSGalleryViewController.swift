//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

final class RSGalleryViewController: RSDetailViewController {
    
    private let stackView: RSStackView = {
        let view = RSStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 20.0
        view.axis = .vertical
        
        return view
    }()
    
    private let presenter: RSGalleryPresenter
    
    init(presenter: RSGalleryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not this time, buddy")
    }
}

// MARK: - UIViewController interface

extension RSGalleryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if let view = view.hitTest(touch.location(in: view), with: event) as? RSGalleryImageView {
            print(view)
        }
    }
}

// MARK: - Private interface

private extension RSGalleryViewController {
    func setupAppearance() {
        view.addSubview(stackView)
        setup(image: presenter.coverImage, title: presenter.title, type: presenter.type)
        
        var lastView: UIView = contentView
        
        presenter.images.forEach { image in
            let view = RSGalleryImageView(image)
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
            if lastView === contentView {
                view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            } else {
                view.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 20.0).isActive = true
                
            }
            lastView = view
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.366),
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
            view.addTarget(self, action: #selector(didSelectImage(_:)), for: .touchUpInside)
        }
        lastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0).isActive = true
    }
    
    @objc func didSelectImage(_ view: RSGalleryImageView) {
        let controller = RSGalleryDetailViewController(image: view.image)
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true)
    }
}
