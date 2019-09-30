//
//  SignatureLineStyle.swift
//  SignatureView
//
//  Created by Christian Ampe on 9/29/19.
//  Copyright © 2019 Christian Ampe. All rights reserved.
//

import UIKit

internal struct SignatureLineStyle {
    internal var color: UIColor
    internal var width: CGFloat
    internal var opacity: CGFloat
    
    internal init(color: UIColor,
                  width: CGFloat,
                  opacity: CGFloat) {
        
        self.color = color
        self.width = width
        self.opacity = opacity
    }
}

internal extension SignatureLineStyle {
    static let `default` = SignatureLineStyle(color: .black,
                                              width: 3,
                                              opacity: 1)
}
