//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

extension String {
    static func from(_ file: String) -> String {
        guard let path = Bundle.main.path(forResource: file, ofType: "txt") else {
            fatalError("LOL, be careful, drink a water")
        }
        // Здесь нет особой причины делать try!.
        // Кроме одной: предупредить случайные удаления файлов в папке Static
        return try! String(contentsOfFile: path)
    }
}

extension Array where Element == UIImage {
    init(base: String, count: Int) {
        self.init((1...count).map { "\(base)-\($0)" }.map { UIImage($0) } )
    }
}

extension UIImage {
    convenience init(_ name: String) {
        self.init(named: name)!
    }
}

enum ContentType {
    case story(Story)
    case gallery(Gallery)
}


struct FillingData {
    static let data: [ContentType] = [
        .story(Story(coverImage: .init("story-1"), title: .from("s1-title"), text: .from("s1-text"), paths: [.story1path1, .story1path2, .story1path3])),
        .story(Story(coverImage: .init("story-2"), title: .from("s2-title"), text: .from("s2-text"), paths: [.story2path1, .story2path2])),
        .gallery(Gallery(coverImage: .init("minsk-0"), title: "Minsk", images: .init(base: "minsk", count: 6))),
        .gallery(Gallery(coverImage: .init("apple-0"), title: "Apple", images: .init(base: "apple", count: 7))),
        .story(Story(coverImage: .init("story-4"), title: .from("s4-title"), text: .from("s4-text"), paths: [.story4path1, .story4path2])),
        .gallery(Gallery(coverImage: .init("code-0"), title: "Code stuff", images: .init(base: "code", count: 10))),
        .gallery(Gallery(coverImage: .init("tesla-0"), title: "Tesla", images: .init(base: "tesla", count: 8))),
        .story(Story(coverImage: .init("story-3"), title: .from("s3-title"), text: .from("s3-text"), paths: [.story3path1, .story3path1, .story3path1, .story3path1]))
    ]
}

struct Story {
    let coverImage: UIImage
    let title: String
    let text: String
    let type: String = String(describing: Story.self)
    let paths: [CGPath]
}

struct Gallery {
    let coverImage: UIImage
    let title: String
    let images: [UIImage]
    let type: String = String(describing: Gallery.self)
}
