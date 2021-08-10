//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

protocol RSStoryPresenting {
    var coverImage: UIImage { get }
    var title: String { get }
    var type: String { get }
    var text: String { get }
    
    var shouldAnimateStory: Bool { get }
    
    var numberOfItems: Int { get }
    func path(at index: Int) -> CGPath
}

final class RSStoryPresenter {
    
    private let story: Story
    private let colorService: FortyTwo
    
    init(story: Story, colorService: FortyTwo = .shared) {
        self.story = story
        self.colorService = colorService
    }
    
}

extension RSStoryPresenter: RSStoryPresenting {
    var coverImage: UIImage { story.coverImage }
    var title: String { story.title }
    var type: String { story.type }
    var text: String { story.text }
    
    var shouldAnimateStory: Bool { colorService.shouldAnimateStory }
    
    var numberOfItems: Int { story.paths.count }
    func path(at index: Int) -> CGPath { story.paths[index] }
}
