//
//  SignatureViewDelegate.swift
//  Signature
//
//  Created by Christian Ampe on 9/29/19.
//  Copyright © 2019 Christian Ampe. All rights reserved.
//

import Foundation

public protocol SignatureViewDelegate: class {
    func signatureView(_ view: SignatureView, didCaptureSignatureWithResult result: Result<Signature, SignatureError>)
    func signatureViewDidBeginDrawing(view: SignatureView)
    func signatureViewIsDrawing(view: SignatureView)
    func signatureViewDidFinishDrawing(view: SignatureView)
    func signatureViewDidCancelDrawing(view: SignatureView)
}

extension SignatureViewDelegate {
    func signatureView(_ view: SignatureView, didCaptureSignatureWithResult result: Result<Signature, SignatureError>) {}
    func signatureViewDidBeginDrawing(view: SignatureView) {}
    func signatureViewIsDrawing(view: SignatureView) {}
    func signatureViewDidFinishDrawing(view: SignatureView) {}
    func signatureViewDidCancelDrawing(view: SignatureView) {}
}
