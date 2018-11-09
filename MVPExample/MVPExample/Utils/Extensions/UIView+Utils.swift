//
//  UIView+Utils.swift
//  MVPExample
//
//  Created by Pablo Dominé on 10/5/17.
//  Copyright © 2017 Lateral View. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            } else {
                return UIColor.clear
            }
        }
        
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffsetX: CGFloat {
        get {
            return layer.shadowOffset.width
        }
        
        set {
            layer.shadowOffset.width = newValue
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat {
        get {
            return layer.shadowOffset.height
        }
        
        set {
            layer.shadowOffset.height = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return UIColor.clear
            }
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    /* If it is turn on, all the shadows are applied to the subviews, including UILabels text. */
    @IBInspectable var rasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        
        set {
            layer.shouldRasterize = newValue
        }
    }
    
    // MARK: - UI
    
    func addShadow(color: CGColor = UIColor(rgbHex: 0xCCCCCC, alpha: 0.5).cgColor) {
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
        layer.shadowColor = color
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0.0
    }
    
    enum SeparatorAlignment {
        case top
        case centerY
        case bottom
    }
    
    @discardableResult func addSeparator(to alignment: SeparatorAlignment, color: UIColor, height: CGFloat = 1) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        line.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(line)
        
        addConstraints([
            NSLayoutConstraint(item: line, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: line, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
            ])
        
        switch alignment {
        case .top:
            addConstraint(NSLayoutConstraint(item: line, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        case .centerY:
            addConstraint(NSLayoutConstraint(item: line, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        case .bottom:
            addConstraint(NSLayoutConstraint(item: line, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        }
        
        return line
    }
    
    func addTopBorderWithColor(color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBorder(mask: CAShapeLayer, with color: UIColor, and thickness: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineWidth = thickness
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    func roundCorners(radius: CGFloat = 5.0) {
        layer.cornerRadius = radius
    }
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        layer.mask = maskLayer1
    }
    
    func makeCircular() {
        setNeedsLayout()
        layoutIfNeeded()
        layer.cornerRadius = min(frame.width, frame.height) / 2
        clipsToBounds = true
    }
    
    class func fromNib<T: UIView>(nibName: String? = nil) -> T? {
        let name = nibName ?? String(describing: self)
        guard let view  = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.last as? T else {
            fatalError("Cannot load from nib \(name)")
        }
        return view
    }
    
    // add another view keeping resizing mask sizes
    func add(to view: UIView) {
        view.addSubview(self)
        
        frame = view.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func currentFirstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        
        for view in subviews {
            if let view = view.currentFirstResponder() {
                return view
            }
        }
        
        return nil
    }
    
    func recursivelyFindSubview(condition: (UIView) -> Bool) -> UIView? {
        if condition(self) {
            return self
        }
        
        for view in subviews {
            if let found = view.recursivelyFindSubview(condition: condition) {
                return found
            }
        }
        
        return nil
    }
    
    func centerInSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerHorizontallyInSuperview()
        self.centerVerticallyInSuperview()
    }
    
    func centerHorizontallyInSuperview() {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1, constant: 0)
        self.superview?.addConstraint(constraint)
    }
    
    func centerVerticallyInSuperview() {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: 0)
        self.superview?.addConstraint(constraint)
    }

    func drawProgress(_ progress: CGFloat, arcColor: UIColor, progressColor: UIColor, thickness: CGFloat) {
        func createPath(progress: CGFloat = 1) -> UIBezierPath {
            return UIBezierPath(arcCenter: CGPoint(x: self.bounds.width/2, y: self.bounds.height/2),
                                radius: (self.bounds.height / 2) - thickness,
                                startAngle: CGFloat(-1/2 * Double.pi),
                                endAngle: CGFloat(2 * Double.pi) * progress - CGFloat(1/2 * Double.pi),
                                clockwise: true)
        }
        
        func createShapeLayer(with path: UIBezierPath, color: UIColor) -> CAShapeLayer {
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.lineWidth = thickness
            layer.strokeColor = color.cgColor
            layer.fillColor = UIColor.clear.cgColor
            
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 10)
            layer.shadowRadius = 20
            
            return layer
        }
        
        let arcPath = createPath()
        let arcLayer = createShapeLayer(with: arcPath, color: arcColor)
        self.layer.addSublayer(arcLayer)
        
        let progressPath = createPath(progress: progress)
        let progressLayer = createShapeLayer(with: progressPath, color: progressColor)
        self.layer.addSublayer(progressLayer)
    }

    // Rotation

    func startRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 1.0
        rotation.isCumulative = true
        rotation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }

    func stopRotation() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }

    // Show and Hide with fade effect

    func show(_ animated: Bool = true, withDuration duration: TimeInterval = GlobalConstants.Animation.defaultDuration, completion: (() -> Void)? = nil) {
        guard self.isHidden == true else {
            completion?()
            return
        }

        self.alpha = 0
        self.isHidden = false

        if animated {
            UIView.animate(withDuration: duration) {
                self.alpha = 1
                completion?()
            }
        } else {
            self.alpha = 1
            completion?()
        }
    }

    func hide(_ animated: Bool = true, withDuration duration: TimeInterval = GlobalConstants.Animation.defaultDuration, completion: (() -> Void)? = nil) {
        guard self.isHidden == false else {
            completion?()
            return
        }

        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.isHidden = true
                completion?()
            })
        } else {
            self.alpha = 0
            self.isHidden = true
            completion?()
        }
    }

    func shake(withDuration duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }

        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)

        propertyAnimator.startAnimation()
    }
}
