//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import Foundation

protocol RSCollectionPresenting {
    var numberOfItems: Int { get }
    
    func type(at index: Int) -> ContentType
}

final class RSCollectionPresenter {
    
    private let data: [ContentType]
    
    init(data: [ContentType] = FillingData.data) {
        self.data = data
    }
    
}

extension RSCollectionPresenter: RSCollectionPresenting {
    
    var numberOfItems: Int {
        data.count
    }
    
    func type(at index: Int) -> ContentType {
        data[index]
    }
}
