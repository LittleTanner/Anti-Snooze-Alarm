//
//  RangeSliderViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/9/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class RangeSliderViewController: UIViewController {
    let rangeSlider = RangeSlider(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rangeSlider)
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(rangeSlider:)), for: .valueChanged)
        
//        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
//        dispatch_after(time, dispatch_get_main_queue()) {
//            self.rangeSlider.trackHighlightTintColor = UIColor.redColor()
//            self.rangeSlider.curvaceousness = 0.0
//        }
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + 20.0, width: width, height: 31.0)
            
    }
    
    
    @objc func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: (\(rangeSlider.lowerValue) \(rangeSlider.upperValue))")
    }
}
