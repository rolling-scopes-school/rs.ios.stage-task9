//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

final class RSCollectionViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        
        view.register(RSCollectionViewCell.self, forCellWithReuseIdentifier: RSCollectionViewCell.reuseIdentifier)
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private let presenter: RSCollectionPresenting
    
    init(presenter: RSCollectionPresenting = RSCollectionPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not this time, buddy")
    }
    
}

// MARK: - UIViewController interface

extension RSCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - Private interface

private extension RSCollectionViewController {
    
    func setupAppearance() {
        view.addSubview(collectionView)
        collectionView.bind(to: view)
    }
}

// MARK: - UICollectionViewDataSource

extension RSCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSCollectionViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? RSCollectionViewCell {
            cell.configure(with: presenter.type(at: indexPath.item))
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RSCollectionViewController: UICollectionViewDelegateFlowLayout {
    private enum LayoutConstants {
        static let cellWidthRatio: CGFloat = 0.41
        static let cellAspectRatio: CGFloat = 1.229
        static let sectionInsets: UIEdgeInsets = .init(top: 40.0, left: 20.0, bottom: 50.0, right: 20.0)
        static let minimumItemSpacing: CGFloat = 4.0
        static let minimumLineSpacing: CGFloat = 30.0
        static let minimumItemSpacingRatio: CGFloat = 0.003865
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * LayoutConstants.cellWidthRatio
        let height = width * LayoutConstants.cellAspectRatio
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        LayoutConstants.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstants.minimumItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstants.minimumLineSpacing
    }
}

// MARK: - UICollectionViewDelegate

extension RSCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = presenter.type(at: indexPath.item)
        switch type {
        case .gallery(let gallery):
            let presenter = RSGalleryPresenter(gallery: gallery)
            let controller = RSGalleryViewController(presenter: presenter)
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
        case .story(let story):
            let presenter = RSStoryPresenter(story: story)
            let controller = RSStoryViewController(presenter: presenter)
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)            
        }
    }
}
