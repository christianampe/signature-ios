import UIKit

extension ACDrawing {
    class View: UIView {
        
        // MARK: - Properties
        
        private var paths = [UITouch: [CGPoint]]()
    }
}

// MARK: - Overrides

extension ACDrawing.View {
    override var bounds: CGRect {
        didSet {
            guard oldValue != bounds else {
                return
            }
            
            redraw(bounds.height / oldValue.height)
        }
    }
}

// MARK: - Public API

extension ACDrawing.View {
    func clear() {
        clearCache()
        clearSublayers()
    }
}

// MARK: - Touch Override Methods

extension ACDrawing.View {
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { manage($0) }
    }
}

// MARK: - Manager Methods

private extension ACDrawing.View {
    func manage(_ touch: UITouch) {
        draw(touch)
        store(touch)
    }
    
    func draw(_ touch: UITouch) {
        let startLocation = touch.precisePreviousLocation(in: self)
        let currentLocation = touch.preciseLocation(in: self)
        
        draw(from: startLocation, to: currentLocation)
    }
    
    func store(_ touch: UITouch) {
        let currentLocation = touch.preciseLocation(in: self)
        
        if paths[touch] == nil {
            let startLocation = touch.precisePreviousLocation(in: self)
            
            paths[touch] = [startLocation, currentLocation]
        } else {
            paths[touch]?.append(currentLocation)
        }
    }
}

// MARK: - Drawing Methods

private extension ACDrawing.View {
    func draw(from startLocation: CGPoint, to currentLocation: CGPoint) {
        let path = UIBezierPath()
        path.move(to: startLocation)
        path.addLine(to: currentLocation)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 3

        layer.addSublayer(shapeLayer)
    }
    
    func redraw(_ heightScaleFactor: CGFloat) {
        clearSublayers()
        
        paths.forEach { (touch, locations) in
            let scaledLocations: [CGPoint] = locations.map { .init(x: $0.x * heightScaleFactor, y: $0.y * heightScaleFactor) }
            
            var startLocation: CGPoint!
            var currentLocation: CGPoint!
            
            for (index, location) in scaledLocations.enumerated() {
                guard index != 0 else {
                    startLocation = location
                    continue
                }
                
                currentLocation = location
                
                draw(from: startLocation, to: currentLocation)
                
                startLocation = currentLocation
            }
            
            paths[touch] = scaledLocations
        }
    }
}

// MARK: - Helper Methods

private extension ACDrawing.View {
    func clearSublayers() {
        layer.sublayers?.removeAll()
    }
    
    func clearCache() {
        paths = [:]
    }
}
