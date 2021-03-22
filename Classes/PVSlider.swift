//
//  PVSlider.swift
//  PVSlider
//
//  Created by Mac Mini on 22/03/21.
//

import Foundation
import UIKit

@IBDesignable
class GradientSlider: UISlider {
    @IBInspectable var thickness: CGFloat = 20 {
        didSet {
            setup()
        }
    }
    @IBInspectable var sliderThumbImage: UIImage? {
        didSet {
            setup()
        }
    }
    @IBInspectable var color1: UIColor? {
        didSet {
            setup()
        }
    }
    @IBInspectable var color2: UIColor? {
        didSet {
            setup()
        }
    }
    @IBInspectable var color3: UIColor? {
        didSet {
            setup()
        }
    }
    func setup() {
        guard let minTrackStartColor = color1 else{return}
        guard let minTrackEndColor = color2 else{return}
        guard let maxTrackColor = color3 else{return}
        do {
            self.setMinimumTrackImage(try self.gradientImage(
            size: self.trackRect(forBounds: self.bounds).size,
                                        colorSet: [minTrackStartColor.cgColor, minTrackEndColor.cgColor]),
                                  for: .normal)
            self.setMaximumTrackImage(try self.gradientImage(
            size: self.trackRect(forBounds: self.bounds).size,
            colorSet: [maxTrackColor.cgColor, maxTrackColor.cgColor]),
                                  for: .normal)
            self.setThumbImage(sliderThumbImage, for: .normal)
        } catch {
            self.minimumTrackTintColor = minTrackStartColor
            self.maximumTrackTintColor = maxTrackColor
        }
    }
    func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
        let tgl = CAGradientLayer()
        tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
        tgl.cornerRadius = tgl.frame.height / 2
        tgl.masksToBounds = false
        tgl.colors = colorSet
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

        UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tgl.render(in: context)
        let image =

    UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
        UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
        UIGraphicsEndImageContext()
        return image!
    }
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: thickness
        )
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
