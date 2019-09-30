import UIKit

extension ACDrawing {
    class TouchManager {
        private var touches: [UITouch: [CGPoint]]
        weak var delegate: ACDrawingTouchManagerDelegate?
        
        init(_ touches: [UITouch: [CGPoint]] = [:]) {
            self.touches = touches
        }
    }
}

extension ACDrawing.TouchManager {
    func update(withTouch touch: UITouch, atLocation location: CGPoint) {
        switch touch.phase {
        case .began:
            touches[touch] = [location]
            
        case .moved:
            guard let touchPoints = touches[touch] else {
                return
            }
            
            touches[touch]?.append(location)
            
            delegate?.touchManager(self, touchUpdatedWithPoints: touchPoints)
            
        case .ended:
            guard let touchPoints = touches[touch] else {
                return
            }
            
            delegate?.touchManager(self, touchCompletedWithPoints: touchPoints)
            
        default:
            break
        }
    }
}
