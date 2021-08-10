//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Uladzislau Volchyk
// On: 26.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSStoryCollectionViewCell: UICollectionViewCell {
    
    private enum AnimationConstants {
        static let interval: TimeInterval = 1 / 30
        static let step: (TimeInterval) -> CGFloat = { CGFloat(1 / (30 * $0))}
        static let duration: TimeInterval = 3
    }
    
    private(set) lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        layer.fillColor = nil
        layer.strokeColor = colorService.selectedColor?.cgColor
        layer.lineCap = .round
        layer.lineWidth = 1.0
        
        return layer
    }()
    
    private weak var timer: Timer?
    
    // В идеале должна быть инъекция зависимости через инициализатор
    // Или передача всех требуемых параметров через публичный метод
    private let colorService: FortyTwo = .shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if colorService.shouldAnimateStory {
            reset()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            run()
        }
    }
}

// MARK: - Public interface

extension RSStoryCollectionViewCell {
    
    func reset() {
        timer?.invalidate()
        shapeLayer.strokeEnd = .start
    }
    
    
    func run() {
        if colorService.shouldAnimateStory {
            reset()
            
            let timer = Timer.scheduledTimer(withTimeInterval: AnimationConstants.interval, repeats: true) { [self] timer in
                if shapeLayer.strokeEnd <= .finish {
                    shapeLayer.strokeEnd += AnimationConstants.step(AnimationConstants.duration)
                } else {
                    timer.invalidate()
                }
            }
            
            self.timer = timer
            RunLoop.current.add(timer, forMode: .common)
        }
    }
}

// MARK: - Private interface

private extension RSStoryCollectionViewCell {
    func setupAppearance() {
        contentView.layer.addSublayer(shapeLayer)
    }
}
