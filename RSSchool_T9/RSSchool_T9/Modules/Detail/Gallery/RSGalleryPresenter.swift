//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

protocol RSGalleryPresenting {
    var coverImage: UIImage { get }
    var title: String { get }
    var type: String { get }
    var images: [UIImage] { get }
}

final class RSGalleryPresenter {
    
    private let gallery: Gallery
    
    init(gallery: Gallery) {
        self.gallery = gallery
    }
    
}

extension RSGalleryPresenter: RSGalleryPresenting {
    var coverImage: UIImage { gallery.coverImage }
    var title: String { gallery.title }
    var type: String { gallery.type }
    var images: [UIImage] { gallery.images }
}
