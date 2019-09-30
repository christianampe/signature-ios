import UIKit

extension ACDrawing {
    class View: UIView {
        let manager = Manager()
        
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
        }
    }
}

// MARK: - Touch Override Methods

extension ACDrawing.View {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { update(manager, withTouch: $0) }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { update(manager, withTouch: $0) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { update(manager, withTouch: $0) }
    }
}

// MARK: - Touch Manager Helper Methods

private extension ACDrawing.View {
    func update(_ manger: ACDrawing.Manager, withTouch touch: UITouch) {
        manger.update(touch, touch.location(in: self))
    }
}

// MARK: - ACDrawingTouchManagerDelegate

extension ACDrawing.View: ACDrawingManagerDelegate {
    
}

//private extension ACDrawing.View {
//    func draw(from startLocation: CGPoint, to endLocation: CGPoint, _ width: CGFloat, _ color: UIColor) {
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//
//        context.setLineCap(.round)
//        context.setLineWidth(width)
//        context.setStrokeColor(color.cgColor)
//
//        context.move(to: startLocation)
//        context.addLine(to: endLocation)
//
//        context.strokePath()
//    }
//}
