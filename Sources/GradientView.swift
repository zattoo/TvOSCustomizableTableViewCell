//
//  GradientView.swift
//  TvOSCustomizableTableViewCell
//
//  Created by David Cordero on 02.09.16.
//  Copyright © 2016 Zattoo, Inc. All rights reserved.
//

import UIKit

final class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var colors: [Any]? {
        set {
            gradientLayer.colors = newValue
        }
        
        get {
            return gradientLayer.colors
        }
    }
    
    var startPoint: CGPoint {
        set {
            gradientLayer.startPoint = newValue
        }
        
        get {
            return gradientLayer.startPoint
        }
    }
    
    var endPoint: CGPoint {
        set {
            gradientLayer.endPoint = newValue
        }
        
        get {
            return gradientLayer.endPoint
        }
    }
    
    // MARK: - Private
    
    private lazy var gradientLayer: CAGradientLayer = {
        return self.layer as! CAGradientLayer
    }()
}
