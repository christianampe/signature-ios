import UIKit

extension ACDrawing {
    class View: UIView {
        let manager = Manager()
        
        private var layers = [CAShapeLayer]()
        private var segments = [Segment]()
        private var redrawnBounds = CGRect()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        private func setup() {
            manager.delegate = self
            redrawnBounds = bounds
        }
    }
}

extension ACDrawing.View {
    override var bounds: CGRect {
        didSet {
            redraw(bounds)
        }
    }
}

// MARK: - Touch Override Methods

extension ACDrawing.View {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { manager.manage($0, in: self) }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { manager.manage($0, in: self) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { manager.manage($0, in: self) }
    }
}

// MARK: - ACDrawingTouchManagerDelegate

extension ACDrawing.View: ACDrawingManagerDelegate {
    func manager(_ manager: ACDrawing.Manager, didConstructSegment segment: ACDrawing.Segment) {
        draw(segment)
    }
}

private extension ACDrawing.View {
    func draw(_ segment: ACDrawing.Segment) {
        
        let path = UIBezierPath()
        path.move(to: segment.startLocation)
        path.addLine(to: segment.endLocation)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = segment.style.color.cgColor
        shapeLayer.lineWidth = segment.style.width

        layer.addSublayer(shapeLayer)
        
        layers.append(shapeLayer)
        segments.append(segment)
    }
    
    func redraw(_ bounds: CGRect) {
        guard bounds != redrawnBounds else {
            return
        }
        
        clear()
        
        let heightScale = bounds.height / redrawnBounds.height
        
        segments = segments.map { ACDrawing.Segment(startLocation: $0.startLocation.applying(.init(scaleX: heightScale, y: heightScale)),
                                                    endLocation: $0.endLocation.applying(.init(scaleX: heightScale, y: heightScale)),
                                                    style: $0.style) }
        
        segments.forEach { draw($0) }
        
        redrawnBounds = bounds
    }
    
    func clear() {
        layers.forEach { $0.removeFromSuperlayer() }
        layers = []
    }
}
