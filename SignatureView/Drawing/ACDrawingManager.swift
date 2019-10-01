import UIKit

extension ACDrawing {
    class Manager {
        private var touches = [UITouch: ([CGPoint], UIView)]()
        weak var delegate: ACDrawingManagerDelegate?
    }
}

extension ACDrawing.Manager {
    func manage(_ touch: UITouch, in view: UIView) {
        let currentTouchLocation = touch.preciseLocation(in: view)
        
        guard let touchPointsInView = touches[touch] else {
            touches[touch] = ([currentTouchLocation], view)
            return
        }
        
        guard let previousTouchLocation = touchPointsInView.0.last else {
            return
        }
        
        touches[touch]?.0.append(currentTouchLocation)
        
        let segment = ACDrawing.Segment(startLocation: previousTouchLocation,
                                        endLocation: currentTouchLocation,
                                        style: .init(color: .black,
                                                     width: 3))
        
        delegate?.manager(self, didConstructSegment: segment)
    }
}
