//
//  SignatureLine.swift
//  Signature
//
//  Created by Christian Ampe on 9/29/19.
//  Copyright © 2019 Christian Ampe. All rights reserved.
//

import UIKit

internal struct SignatureLine {
    internal var path: CGMutablePath
    internal var style: SignatureLineStyle
    
    internal init(path : CGMutablePath,
                  style: SignatureLineStyle) {
        
        self.path = path
        self.style = style
    }
}
