//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSStoryViewController: RSDetailViewController {
    
    private var isCanvasVisible: Bool = true
    
    let textView: UITextView = {
        let view = UITextView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .rockwell(size: 24.0)
        view.backgroundColor = .black
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 8.0
        view.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 40)
        view.isEditable = false
        view.textColor = .white
        view.isScrollEnabled = false
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(RSStoryCollectionViewCell.self, forCellWithReuseIdentifier: RSStoryCollectionViewCell.reuseIdentifier)
        
        return view
    }()
    
    private let presenter: RSStoryPresenting
    
    init(presenter: RSStoryPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        scrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not this time, buddy")
    }
    
}

// MARK: - UIViewController interface

extension RSStoryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
}

// MARK: - Public interface

extension RSStoryViewController {
    
}

// MARK: - Private interface

private extension RSStoryViewController {
    
    func setupAppearance() {
        contentView.addSubview(textView)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            textView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40.0),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        textView.text = presenter.text
        setup(image: presenter.coverImage, title: presenter.title, type: presenter.type)
    }
}

// MARK: - UICollectionViewDataSource

extension RSStoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSStoryCollectionViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? RSStoryCollectionViewCell {
            cell.shapeLayer.path = presenter.path(at: indexPath.item)
            cell.shapeLayer.strokeEnd = presenter.shouldAnimateStory ? .start : .finish
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RSStoryViewController: UICollectionViewDelegateFlowLayout {
    
    private enum LayoutConstants {
        static let canvasSize: CGSize = .init(width: 75, height: 75)
        static let canvasSpacing: CGFloat = 100.0
        static let canvasInsets: UIEdgeInsets = .init(top: 0.0, left: 50.0, bottom: 0.0, right: 20.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        LayoutConstants.canvasSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstants.canvasSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        LayoutConstants.canvasInsets
    }
}

// MARK: - UICollectionViewDelegate

extension RSStoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? RSStoryCollectionViewCell {
            cell.run()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? RSStoryCollectionViewCell {
            cell.reset()
        }
    }
}

// MARK: - UIScrollViewDelegate

extension RSStoryViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isCollectionVisible = collectionView.isVisible(in: scrollView)
        if !isCanvasVisible, isCollectionVisible {
            collectionView.reloadData()
            isCanvasVisible = true
        } else if !isCollectionVisible, isCanvasVisible {
            isCanvasVisible = false
            collectionView.visibleCells.compactMap { $0 as? RSStoryCollectionViewCell }.forEach { $0.reset() }
        }
    }
}
