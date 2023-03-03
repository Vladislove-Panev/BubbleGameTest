//
//  CustomCircleView.swift
//  BubbleGameTest
//
//  Created by Vladislav Panev on 03.03.2023.
//

import UIKit

@IBDesignable final class CustomCircleView: UIView {
    
    @IBOutlet private var circleView: UIView!
    
    @IBInspectable var roundCircle: Bool = false {
        didSet {
            if roundCircle {
                circleView.layer.cornerRadius = frame.width / 2
            }
        }
    }
    
    @IBInspectable var circleBackgroundColor: UIColor? {
        get {
            circleView.backgroundColor
        }
        set {
            circleView.backgroundColor = newValue
        }
    }
    
    var workingView: UIView!
    var xibName = "CustomCircleView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomView()
    }
    
    override func prepareForInterfaceBuilder() {
        if roundCircle {
            circleView.layer.cornerRadius = frame.width / 2
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if roundCircle {
            circleView.layer.cornerRadius = frame.width / 2
        }
    }
    
    private func setCustomView() {
        workingView = getFromXib() ?? UIView()
        workingView.frame = bounds
        workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(workingView)
    }
    
    private func getFromXib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: xibName, bundle: bundle)
        let view = xib.instantiate(withOwner: self).first as? UIView
        return view
    }
}
