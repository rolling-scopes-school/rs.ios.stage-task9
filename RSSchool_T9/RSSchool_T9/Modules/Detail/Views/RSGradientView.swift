//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 26.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSGradientView: UIView {
    
    typealias Color = (color: UIColor, point: Float)

    convenience init() {
        self.init(frame: .zero)
    }
}

// MARK: - UIView interface

extension RSGradientView {
    
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.bounds = bounds
    }
}

// MARK: - Public interface

extension RSGradientView {
    
    func applyColors(_ colors: Color...) {
        let (colors, points) = unzip(sequence: colors)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = points.map { NSNumber(value: $0) }
    }
    
    func applyRadius(_ radius: CGFloat) {
        gradientLayer.cornerRadius = radius
    }
}

// MARK: - Private interface

private extension RSGradientView {
    
    private var gradientLayer: CAGradientLayer {
        // Здесь предполагается, что as! никогда не упадёт,
        // потому что в качестве layerClass как раз указан CAGradientLayer
        layer as! CAGradientLayer
    }
}
