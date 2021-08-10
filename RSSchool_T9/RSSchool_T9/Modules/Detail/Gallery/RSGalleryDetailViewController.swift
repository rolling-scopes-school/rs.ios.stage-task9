//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 26.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSGalleryDetailViewController: UIViewController {

    private let closeButton: RSCloseButton = {
        let view = RSCloseButton()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        view.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not this time, buddy")
    }
}

// MARK: - UIViewController interface

extension RSGalleryDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
    }
}

// MARK: - Private interface

private extension RSGalleryDetailViewController {
    func setupAppearance() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.addSubview(imageView)
        
        scrollView.bind(to: view)
        imageView.bind(to: scrollView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: 40.0),
            closeButton.widthAnchor.constraint(equalToConstant: 40.0),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0)
        ])
        
        view.backgroundColor = .black
        
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3.0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc func dismissAction() {
        dismiss(animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension RSGalleryDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    @objc func handleTap() {
        closeButton.isHidden.toggle()
    }
}
