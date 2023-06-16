//
//  ProgressBarView.swift
//  ITunesApp
//
//  Created by serdar on 15.06.2023.
//

import Foundation
import UIKit

final class ProgressBarView: UIView {
    private var progressLayer: CALayer!
    private var progress: CGFloat = 0.0
    private var backgroundLayer: CALayer!
    private var elapsedTimeLabel: UILabel!
    private var totalTimeLabel: UILabel!
    
    var elapsedTime: String? {
        didSet {
            setElapsedTime(elapsedTime)
        }
    }
    
    var totalTime: String? {
        didSet {
            setTotalTime(totalTime)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressLayer()
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressLayer()
        setupLabels()
    }
    
    private func setupProgressLayer() {
        backgroundLayer = CALayer()
        backgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        
        
        layer.addSublayer(backgroundLayer)
        progressLayer = CALayer()
        progressLayer.backgroundColor = UIColor.white.cgColor
        layer.addSublayer(progressLayer)
    }
    
    private func setupLabels() {
        let labelHeight: CGFloat = 20
        let labelSpacing: CGFloat = 8
        
        elapsedTimeLabel = UILabel(frame: CGRect(x: 0, y: bounds.height - labelHeight, width: bounds.width / 2, height: labelHeight))
        elapsedTimeLabel.textColor = UIColor.white
        elapsedTimeLabel.textAlignment = .left
        addSubview(elapsedTimeLabel)
        
        totalTimeLabel = UILabel(frame: CGRect(x: bounds.width / 2, y: bounds.height - labelHeight, width: bounds.width / 2, height: labelHeight))
        totalTimeLabel.textColor = UIColor.white
        totalTimeLabel.textAlignment = .right
        addSubview(totalTimeLabel)
        
        let progressViewHeight = bounds.height - labelHeight - labelSpacing
        progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: progressViewHeight)
    }
    
    func setProgress(_ progress: CGFloat) {
        self.progress = max(0.0, min(progress, 1.0))
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let progressWidth = bounds.width * progress
        let progressViewHeight = bounds.height - elapsedTimeLabel.frame.height - 10
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - elapsedTimeLabel.frame.height - 10)
        progressLayer.frame = CGRect(x: 0, y: 0, width: progressWidth, height: progressViewHeight)
    }
    
    func setElapsedTime(_ time: String?) {
        elapsedTimeLabel.text = time
    }
    
    func setTotalTime(_ time: String?) {
        totalTimeLabel.text = time
    }
}
