//
//  CoachCollectionViewController.swift
//  Develop
//
//  Created by Truman, Christopher on 8/8/19.
//  Copyright © 2019 Truman. All rights reserved.
//

import UIKit
import SafariServices

let Defaults = UserDefaults.standard
let Notifications = NotificationCenter.default

// MARK: Utilities

protocol Then {}
extension Then where Self: AnyObject { func then(_ block: (Self) -> Void) -> Self { block(self); return self } }
extension NSObject: Then {}

extension Int {
    func perform(_ closure: () -> Void) { (0..<self).forEach { _ in closure() } }
    func performIndex(_ closure: @escaping (Int) -> Void) { (0..<self).forEach { index in closure(index) } }
    init(_ bool: Bool) { self.init(bool ? 1 : 0) }
}

extension Collection {
    public subscript(safe index: Index) -> Element? { return index >= startIndex && index < endIndex ? self[index] : nil }
}

extension UserDefaults {
    subscript(key: String) -> Any? { return object(forKey: key) }
}

extension NotificationCenter {
    static func post(name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    static func addObserver(name: Notification.Name, callback: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: OperationQueue.main, using: callback)
    }
}

// MARK: UIKit Convenience APIs

extension UIAlertController {
    func addActions(_ actions: UIAlertAction...) { for action in actions { addAction(action) } }
    static func sheet(title: String? = nil, message: String? = nil) -> UIAlertController { return UIAlertController(title: title, message: message, preferredStyle: .actionSheet) }
    static func alert(title: String? = nil, message: String? = nil) -> UIAlertController { return UIAlertController(title: title, message: message, preferredStyle: .alert) }
}

extension UIAlertAction {
    convenience init(_ title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)? = nil) { self.init(title: title, style: style, handler: handler) }
    static func cancel(handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction { return UIAlertAction("Cancel", style: .cancel, handler: handler) }
    static func ok(handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction { return UIAlertAction("OK", style: .cancel, handler: handler) }
}

extension UIBarButtonItem {
    convenience init(_ image: UIImage, style: UIBarButtonItem.Style = .plain, target: AnyObject, action: Selector) { self.init(image: image, style: .plain, target: target, action: action) }
}

extension UIButton {
    var title: String { set { setTitle(newValue, for: .normal) } get { return title(for: .normal)! } }
    var titleColor: UIColor { set { setTitleColor(newValue, for: .normal) } get { return titleColor(for: .normal)! } }
    var image: UIImage { set { setImage(newValue, for: .normal) } get { return image(for: .normal)! } }
    
    override open var intrinsicContentSize : CGSize {
        get {
            let intrinsicContentSize = super.intrinsicContentSize
            let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
            let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
            
            return CGSize(width: adjustedWidth, height: adjustedHeight)
        }
    }
}

extension UICollectionView {
    func registerClass(_ cellClasses: AnyClass...) { for aClass in cellClasses { register(aClass, forCellWithReuseIdentifier: String(describing: aClass)) } }
    func registerNib(_ cellClasses: AnyClass...) { for aClass in cellClasses { let string = String(describing: aClass); register(UINib(nibName: string, bundle: nil), forCellWithReuseIdentifier: string) } }
    func dequeue<T: UICollectionViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T { let string = String(describing: cellClass); return dequeueReusableCell(withReuseIdentifier: string, for: indexPath) as! T }
}

extension UITableView {
    func registerClass(_ cellClasses: AnyClass...) { for aClass in cellClasses { register(aClass, forCellReuseIdentifier: String(describing: aClass)) } }
    func registerNib(_ cellClasses: AnyClass...) { for aClass in cellClasses { let string = String(describing: aClass); register(UINib(nibName: string, bundle: nil), forCellReuseIdentifier: string) } }
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T { let string = String(describing: cellClass); return dequeueReusableCell(withIdentifier: string, for: indexPath) as! T }
}

extension UIStackView {
    convenience init(_ views : UIView..., axis : NSLayoutConstraint.Axis = .horizontal, spacing : CGFloat = 0) { self.init(arrangedSubviews: views); self.axis = axis; self.spacing = spacing }
}

extension UIView {
    
    // MARK: UIView Autolayout Convenience APIs
    
    var translates: Bool { get { return translatesAutoresizingMaskIntoConstraints } set { translatesAutoresizingMaskIntoConstraints = newValue } }
    convenience init(translates: Bool) { self.init(); self.translates = translates }
    
    func constrain(_ constants: (attr: NSLayoutConstraint.Attribute, const: CGFloat)..., toItem: UIView? = nil) {
        for constantPair in constants {
            NSLayoutConstraint(item: self, attribute: constantPair.attr, relatedBy: .equal, toItem: toItem, attribute: (toItem == nil) ? .notAnAttribute : constantPair.attr, multiplier: 1.0, constant:constantPair.const).isActive = true
        }
    }
    
    func constrain(_ attributes: NSLayoutConstraint.Attribute..., relatedBy: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0, toItem: UIView? = nil, toAttribute: NSLayoutConstraint.Attribute = .notAnAttribute, multiplier: CGFloat = 1.0) {
        for attribute in attributes {
            let toAttributeChoice = toAttribute == .notAnAttribute ? attribute : toAttribute
            NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: (toItem == nil) ? .notAnAttribute : toAttributeChoice, multiplier: multiplier, constant:constant).isActive = true
        }
    }
    
    func constraint(_ attribute: NSLayoutConstraint.Attribute, relatedBy: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0, toItem: UIView? = nil, toAttribute: NSLayoutConstraint.Attribute = .notAnAttribute, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let toAttributeChoice = toAttribute == .notAnAttribute ? attribute : toAttribute
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: (toItem == nil) ? .notAnAttribute : toAttributeChoice, multiplier: multiplier, constant:constant)
    }
    
    var heightConstraint: NSLayoutConstraint? { return constraintFor(.height) }; var widthConstraint: NSLayoutConstraint? { return constraintFor(.width) }
    var topConstraint: NSLayoutConstraint? { return constraintFor(.top) }; var bottomConstraint: NSLayoutConstraint? { return constraintFor(.bottom) }
    var leadingConstraint: NSLayoutConstraint? { return constraintFor(.leading) }; var trailingConstraint: NSLayoutConstraint? { return constraintFor(.trailing) }
    
    func constraintFor(_ attribute: NSLayoutConstraint.Attribute, toItem: UIView? = nil) -> NSLayoutConstraint? {
        guard let item = toItem as UIView? else { return constraints.filter({ return $0.firstAttribute == attribute }).first }
        return constraints.filter({ return $0.firstAttribute == attribute && $0.firstItem as! UIView == item }).first
    }
    
    func addSubviews(_ views: UIView...) { views.forEach { addSubview($0) } }
    
    // MARK: UIView Animations

    func fadeIn(duration: TimeInterval = 0.2, delay: TimeInterval = 0, completion:@escaping (() -> Void) = {}) { alpha = 0.0; UIView.animate(withDuration: duration, delay: delay, animations: { self.alpha = 1.0 }, completion: { _ in completion() }) }
    func fadeOut(duration: TimeInterval = 0.2, delay: TimeInterval = 0, completion:@escaping (() -> Void) = {}) { UIView.animate(withDuration: duration, delay: delay, animations: { self.alpha = 0.0 }, completion: { _ in completion() }) }
    
    func scaleIn(delay: TimeInterval = 0, completion: @escaping ((Bool) -> Void) = {_ in }) {
        self.transform = self.transform.scaledBy(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.25, initialSpringVelocity: 5, options: .allowUserInteraction, animations: {
            self.transform = .identity }, completion: nil)
    }
    
    func squeezeIn(delay: TimeInterval = 0, completion: @escaping ((Bool) -> Void) = {_ in }) {
        UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: .allowUserInteraction, animations: { self.transform = self.transform.scaledBy(x: 0.9, y: 0.9) }, completion: nil)
    }
    func squeezeOut(delay: TimeInterval = 0, completion: @escaping ((Bool) -> Void) = {_ in }) {
        UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .allowUserInteraction, animations: { self.transform = .identity }, completion: completion)
    }
    func squeezeInOut(delay: TimeInterval = 0, completion: @escaping ((Bool) -> Void) = {_ in }) { squeezeIn(delay: delay); squeezeOut(delay: 0.2, completion: completion) }
    
    func round(corners: UIRectCorner = UIRectCorner.allCorners, radius: CGFloat = 10) {
        let rect = bounds
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer(); maskLayer.frame = rect; maskLayer.path = maskPath.cgPath; maskLayer.frame.size.height = 5
        layer.mask = maskLayer
    }
    
    func round(radius: CGFloat = 10.0) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

extension UINavigationController {
    func push(_ viewController: UIViewController, animated: Bool = true) { pushViewController(viewController, animated: animated) }
    func pop(_ animated: Bool = true) { popViewController(animated: animated) }
    
    func safari(_ url: String, push: Bool = true, delegate: SFSafariViewControllerDelegate? = nil) {
        let safari = SFSafariViewController(url: URL(string: url)!); safari.hidesBottomBarWhenPushed = true; safari.delegate = delegate
        if push { self.push(safari) }
        else { safari.modalPresentationStyle = .popover; self.present(safari) }
    }
}

extension UIViewController {
    func present(_ vc: UIViewController, animated: Bool = true) { present(vc, animated: animated, completion: nil) }
    func dismiss(animated: Bool = true) { dismiss(animated: animated, completion: nil) }
    func withNav() -> UINavigationController { return UINavigationController(rootViewController: self) }
}

extension UIFont {
    //TODO: Choose font, support dynamic type
    //    static func gothamBook(ofSize: CGFloat) -> UIFont { return UIFont(name: "Gotham Book", size: ofSize)! }
}

// MARK: UIMotionEffect
extension UIMotionEffectGroup { convenience init(_ motionEffects: [UIMotionEffect]) { self.init(); self.motionEffects = motionEffects } }

extension UIMotionEffect {
    class func twoAxesTilt(strength: Float) -> UIMotionEffect {
        func relativeValue(_ isMax: Bool, type: UIInterpolatingMotionEffect.EffectType) -> NSValue {
            var transform = CATransform3DIdentity
            transform.m34 = (1.0 * CGFloat(strength)) / 2000.0
            
            let axisValue: CGFloat
            if type == .tiltAlongVerticalAxis {
                axisValue = isMax ? -1.0 : 1.0
                transform = CATransform3DRotate(transform, axisValue * CGFloat(Double.pi/4), 1, 0, 0)
            } else {
                axisValue = isMax ? 1.0 : -1.0
                transform = CATransform3DRotate(transform, axisValue * CGFloat(Double.pi/4), 0, 1, 0)
            }
            return NSValue(caTransform3D: transform)
        }
        
        func motion(_ type: UIInterpolatingMotionEffect.EffectType) -> UIInterpolatingMotionEffect {
            let motion = UIInterpolatingMotionEffect(keyPath: "layer.transform", type: type)
            motion.minimumRelativeValue = relativeValue(false, type: type); motion.maximumRelativeValue = relativeValue(true, type: type)
            return motion
        }
        
        return UIMotionEffectGroup([motion(.tiltAlongHorizontalAxis), motion(.tiltAlongVerticalAxis)])
    }
}

extension UIImage {
    static func imageWithColor(_ color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor); context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext()
        return image!
    }
}
