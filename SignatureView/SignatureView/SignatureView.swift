//
//  SignatureView.swift
//  Signature
//
//  Created by Christian Ampe on 9/29/19.
//  Copyright © 2019 Christian Ampe. All rights reserved.
//

import UIKit

// MARK: - Class Declaration

open class SignatureView: UIView {
    
    // MARK: - Public Properties
    
    public var lineColor: UIColor = SignatureLineStyle.default.color
    public var lineWidth: CGFloat = SignatureLineStyle.default.width
    public var lineOpacity: CGFloat = SignatureLineStyle.default.opacity
    
    public var isDrawingEnabled: Bool = true
    public var isSignatureOpaque: Bool = true
    
    public weak var delegate: SignatureViewDelegate?
    
    // MARK: - Private Properties
    
    private var pathArray = [SignatureLine]()
    
    private var currentPoint = CGPoint()
    private var previousPoint = CGPoint()
    private var previousPreviousPoint = CGPoint()
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
}

// MARK: - Override Methods

extension SignatureView {
    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.setLineCap(.round)
        
        pathArray.forEach { draw($0, inContext: context) }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawingEnabled else {
            return
        }
        
        delegate?.signatureViewDidBeginDrawing(view: self)
        
        guard let touch = touches.first else {
            return
        }
        
        setTouchPoints(touch, view: self)
        
        let newLine = SignatureLine(path: .init(),
                                    style: SignatureLineStyle(color: lineColor,
                                                              width: lineWidth,
                                                              opacity: lineOpacity))
        
        newLine.path.addPath(createNewPath())
        
        pathArray.append(newLine)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawingEnabled else {
            return
        }
        
        delegate?.signatureViewIsDrawing(view: self)
        
        guard let touch = touches.first else {
            return
        }
        
        updateTouchPoints(touch, view: self)
        
        let newLine = createNewPath()
        
        guard let currentPath = pathArray.last else {
            return
        }
        
        currentPath.path.addPath(newLine)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawingEnabled else {
            return
        }
        
        delegate?.signatureViewDidFinishDrawing(view: self)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawingEnabled else {
            return
        }
        
        delegate?.signatureViewDidCancelDrawing(view: self)
    }
}

// MARK: - Public Getters

public extension SignatureView {
    var isSignaturePresent: Bool {
        return !pathArray.isEmpty
    }
}

// MARK: - Public Functions

public extension SignatureView {
    func clear() {
        pathArray = []
        setNeedsDisplay()
    }
    
    func capture() {
        guard isSignaturePresent else {
            delegate?.signatureView(self, didCaptureSignatureWithResult: .failure(.empty))
            return
        }
        
        guard let image = captureSignatureFromView() else {
            delegate?.signatureView(self, didCaptureSignatureWithResult: .failure(.corruption))
            return
        }
        
        delegate?.signatureView(self, didCaptureSignatureWithResult: .success(Signature(image: image)))
    }
}

// MARK: - Private Functions

private extension SignatureView {
    func captureSignatureFromView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isSignatureOpaque, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        layer.render(in: context)
        
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return viewImage
    }
    
    func draw(_ line: SignatureLine, inContext context: CGContext) {
        context.setLineWidth(line.style.width)
        context.setAlpha(line.style.opacity)
        context.setStrokeColor(line.style.color.cgColor)
        context.addPath(line.path)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        context.strokePath()
        context.endTransparencyLayer()
    }
    
    func setTouchPoints(_ touch: UITouch, view: UIView) {
        previousPoint = touch.previousLocation(in: view)
        previousPreviousPoint = touch.previousLocation(in: view)
        currentPoint = touch.location(in: view)
    }
    
    func updateTouchPoints(_ touch: UITouch, view: UIView) {
        previousPreviousPoint = previousPoint
        previousPoint = touch.previousLocation(in: view)
        currentPoint = touch.location(in: view)
    }
    
    func createNewPath() -> CGMutablePath {
        let midPoints = getMidPoints()
        let subPath = createSubPath(midPoints.0, mid2: midPoints.1)
        let newPath = addSubPathToPath(subPath)
        
        return newPath
    }
    
    func calculateMidPoint(_ p1 : CGPoint, p2 : CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) * 0.5, y: (p1.y + p2.y) * 0.5)
    }
    
    func getMidPoints() -> (CGPoint,  CGPoint) {
        let mid1 = calculateMidPoint(previousPoint, p2: previousPreviousPoint)
        let mid2 = calculateMidPoint(currentPoint, p2: previousPoint)
        
        return (mid1, mid2)
    }
    
    func createSubPath(_ mid1: CGPoint, mid2: CGPoint) -> CGMutablePath {
        let subpath = CGMutablePath()
        
        subpath.move(to: CGPoint(x: mid1.x, y: mid1.y))
        subpath.addQuadCurve(to: CGPoint(x: mid2.x, y: mid2.y),
                             control: CGPoint(x: previousPoint.x, y: previousPoint.y))
        
        return subpath
    }
    
    func addSubPathToPath(_ subpath: CGMutablePath) -> CGMutablePath {
        let bounds: CGRect = subpath.boundingBox
        let drawBox: CGRect = bounds.insetBy(dx: -2.0 * lineWidth, dy: -2.0 * lineWidth)
        
        setNeedsDisplay(drawBox)
        
        return subpath
    }
}

// MARK: - Observer Methods

private extension SignatureView {
    @objc func deviceOrientationDidChange(_ notification: UIDeviceOrientation) {
        setNeedsDisplay()
    }
}
