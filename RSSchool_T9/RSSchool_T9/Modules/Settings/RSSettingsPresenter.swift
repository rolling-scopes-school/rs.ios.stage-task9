//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 25.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

typealias RSSettingsPresenting = RSGlobalSettingsPresenting & RSColorSettingsPresenting

protocol RSGlobalSettingsPresenting {
    var selectedColor: UIColor? { get }
    var selectedColorString: String { get }
    
    var shouldAnimateStory: Bool { get }
    
    var colorRowTitle: String { get }
    var animationRowTitle: String { get }
    var settingsTitle: String { get }
    
    func toggleAnimation(_ isOn: Bool)
}

protocol RSColorSettingsPresenting {
    var numberOfItems: Int { get }
    
    func color(at index: Int) -> UIColor?
    func shouldMark(at index: Int) -> Bool
}

final class RSSettingsPresenter {
    
    private enum Strings {
        static let colorRowTitle: String = "Stroke color"
        static let animationRowTitle: String = "Draw stories"
        static let screenTitle: String = "Settings"
        
        static let noColorTitle: String = "No selected color"
    }
    
    private let colorService: FortyTwo
    
    init(colorService: FortyTwo = .shared) {
        self.colorService = colorService
    }
}

extension RSSettingsPresenter: RSGlobalSettingsPresenting {
    
    var selectedColor: UIColor? {
        colorService.selectedColor
    }
    
    var selectedColorString: String {
        colorService.selectedColor?.hexString ?? Strings.noColorTitle
    }
    
    var shouldAnimateStory: Bool {
        colorService.shouldAnimateStory
    }
    
    var colorRowTitle: String {
        Strings.colorRowTitle
    }
    
    var animationRowTitle: String {
        Strings.animationRowTitle
    }
    
    var settingsTitle: String {
        Strings.screenTitle
    }
    
    func toggleAnimation(_ isOn: Bool) {
        colorService.toggleAnimation(isOn: isOn)
    }
}

extension RSSettingsPresenter: RSColorSettingsPresenting {
    
    var numberOfItems: Int {
        colorService.availableColors.count
    }
    
    func color(at index: Int) -> UIColor? {
        colorService.availableColors[index]
    }
    
    func shouldMark(at index: Int) -> Bool {
        colorService.availableColors[index].isEqual(colorService.selectedColor)
    }
}
