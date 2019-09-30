//
//  SignatureError.swift
//  Signature
//
//  Created by Christian Ampe on 9/29/19.
//  Copyright © 2019 Christian Ampe. All rights reserved.
//

import Foundation

public enum SignatureError: Error {
    case empty
    case corruption
}
