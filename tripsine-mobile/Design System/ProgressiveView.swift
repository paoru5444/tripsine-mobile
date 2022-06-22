//
//  ProgressiveView.swift
//  tripsine-mobile
//
//  Created by Bianca on 22/06/22.
//

import UIKit

class ProgressView: UIView {
    
    // MARK: - Animations
    func animateStroke() {
        let startAnimation = StrokeAnimation(
            type: .start,
            beginTime: 0.05,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.5
        )

        let endAnimation = StrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.5
        )
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]

        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        self.layer.addSublayer(shapeLayer)
    }
    
    init(frame: CGRect,
         colors: [UIColor],
         lineWidth: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth
        
        super.init(frame: frame)
    
        self.backgroundColor = .clear
    }
    
    convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width / 2
        
        let path = UIBezierPath(ovalIn: CGRect(
                                        x: 0,
                                        y: 0,
                                        width: self.bounds.width,
                                        height: self.bounds.width))
        shapeLayer.path = path.cgPath
    }
    
    let colors: [UIColor]
    let lineWidth: CGFloat
    
    private lazy var shapeLayer: ProgressShapeLayer = {
        return ProgressShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()
}
