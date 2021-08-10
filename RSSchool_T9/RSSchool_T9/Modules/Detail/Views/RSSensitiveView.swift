//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 26.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSSensitiveView: UIView {
    
    private var observation: NSKeyValueObservation!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func viewDidBecomeVisible() {}
}

// MARK: - Private interface

private extension RSSensitiveView {
    func setup() {
        observation = observe(\.window, changeHandler: { [weak self] object, change in
            guard let self = self else {
                return
            }
            if object.window != nil {
                self.viewDidBecomeVisible()
            }
        })
    }
}

