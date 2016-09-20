//
//  ProgressSearchBar.swift
//  itstime
//
//  Created by Martin MOIZARD-LANVIN on 20/09/16.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import CoreGraphics

class ProgressView: UIView {
    
    var progress: Int = 50 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var progressColor: UIColor = UIColor.darkGray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let yLine = self.bounds.height / 2;
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(self.bounds.height)
        context?.setStrokeColor(self.progressColor.cgColor)
        context?.move(to: CGPoint(x: 0, y: yLine))
        context?.addLine(to: CGPoint(x: (CGFloat(self.progress) * self.bounds.width) / 100, y: yLine))
        context?.strokePath()
    }
}

class ProgressSearchBar: UISearchBar {
    var progressView = ProgressView()
    
    var progress: Int = 50 {
        didSet {
            self.progressView.progress = self.progress
        }
    }
    
    var progressLineWidth: Int = 1 {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addProgressView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addProgressView()
    }
    
    internal func addProgressView() {
        self.progressView.backgroundColor = UIColor.clear
        self.addSubview(self.progressView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.progressView.frame = CGRect(x: 0,
                                          y: self.bounds.height - CGFloat(self.progressLineWidth),
                                          width: self.bounds.width,
                                          height: CGFloat(self.progressLineWidth))
    }
    
    func setProgress(p: Int) {
        self.progressView.progress = p
    }
    
    func setProgressColor(color: UIColor) {
        self.progressView.progressColor = color
    }
}

class AutoProgressSearchBar: ProgressSearchBar {
    //TODO
}
