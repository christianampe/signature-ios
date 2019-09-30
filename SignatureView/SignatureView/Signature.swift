//
//  Signature.swift
//  Signature
//
//  Created by Christian Ampe on 9/29/19.
//  Copyright © 2019 Christian Ampe. All rights reserved.
//

import UIKit.UIImage

public struct Signature {
    private(set) public var image: UIImage
    private(set) public var date: Date
    
    init(image: UIImage,
         date: Date = .init()) {
        
        self.image = image
        self.date = date
    }
}
