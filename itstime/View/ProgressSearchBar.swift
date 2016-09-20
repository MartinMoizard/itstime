//
//  ProgressSearchBar.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 20/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import CoreGraphics

class ProgressLayer: CAShapeLayer {
    @NSManaged var progress: CGFloat
    @NSManaged var progressColor: UIColor
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "progress" || key == "progressColor" {
            return true;
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func display() {
        let l = presentation() ?? self
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let yLine = self.bounds.height / 2;
        context?.setLineWidth(self.bounds.height)
        context?.setStrokeColor(l.progressColor.cgColor)
        context?.move(to: CGPoint(x: 0, y: yLine))
        context?.addLine(to: CGPoint(x: (l.progress * self.bounds.width) / 100, y: yLine))
        context?.strokePath()
        self.contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()
    }
}

protocol HasProgress {
    var progress: CGFloat { get set }
    var progressLineWidth: CGFloat { get set }
    var progressLayer: ProgressLayer { get set }
    
    func insertProgressLayer()
    func layoutProgressLayer(withParentBounds parentBounds: CGRect)
    func setProgress(progress: CGFloat, withDuration duration: TimeInterval)
}

var progressAttr = "progressAttr"
var progressLineWidthAttr = "progressLineWidthAttr"
var progressLayerAttr = "progressLayerAttr"

extension HasProgress where Self: UIView {
    var progress: CGFloat {
        get {
            if let progress = objc_getAssociatedObject(self, &progressAttr) as? CGFloat {
                return progress
            }
            let progress: CGFloat = 0.0
            objc_setAssociatedObject(self, &progressAttr, progress, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            return progress
        }
        set {
            self.progressLayer.progress = newValue
            objc_setAssociatedObject(self, &progressAttr, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    var progressLineWidth: CGFloat {
        get {
            if let progressLineWidth = objc_getAssociatedObject(self, &progressLineWidthAttr) as? CGFloat {
                return progressLineWidth
            }
            let progressLineWidth: CGFloat = 1.0
            objc_setAssociatedObject(self, &progressLineWidthAttr, progressLineWidth, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            return progressLineWidth
        }
        set {
            objc_setAssociatedObject(self, &progressLineWidthAttr, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    var progressLayer: ProgressLayer {
        get {
            if let progressLayer = objc_getAssociatedObject(self, &progressLayerAttr) as? ProgressLayer {
                return progressLayer
            }
            let progressLayer = ProgressLayer()
            objc_setAssociatedObject(self, &progressLayerAttr, progressLayer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return progressLayer
        }
        set {
            objc_setAssociatedObject(self, &progressLayerAttr, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func insertProgressLayer() {
        self.layer.addSublayer(self.progressLayer)
    }
    
    func layoutProgressLayer(withParentBounds parentBounds: CGRect) {
        self.progressLayer.frame = CGRect(x: 0,
                                          y: parentBounds.height - CGFloat(self.progressLineWidth),
                                          width: parentBounds.width,
                                          height: CGFloat(self.progressLineWidth))
    }
    
    func setProgress(progress: CGFloat, withDuration duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "progress")
        animation.fromValue = self.progress
        animation.toValue = progress
        animation.duration = duration
        self.progressLayer.progress = progress
        self.progressLayer.add(animation, forKey: "progress")
    }
}

class ProgressSearchBar: UISearchBar, HasProgress {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.insertProgressLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.insertProgressLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutProgressLayer(withParentBounds: self.bounds)
        
        self.setProgress(progress: 50, withDuration: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//            let animation = CABasicAnimation(keyPath: "progress")
//            animation.fromValue = 0
//            animation.toValue = 100
//            animation.duration = 5.0
//            self.progressLayer.progress = 100
//            self.progressLayer.add(animation, forKey: "progress")
            self.setProgress(progress: 100, withDuration: 5.0)
        })
    }
}

class AutoProgressSearchBar: ProgressSearchBar {
    //TODO
}
