import UIKit

extension ACDrawing {
    class Manager {
        let touchManager = TouchManager()
        let segmentManager = SegmentManager()
        let strokeManager = StrokeManager()
        
        weak var delegate: ACDrawingManagerDelegate?
        
        init() {
            setup()
        }
        
        private func setup() {
            touchManager.delegate = self
            segmentManager.delegate = self
            strokeManager.delegate = self
        }
    }
}

extension ACDrawing.Manager {
    func update(_ touch: UITouch, _ location: CGPoint) {
        touchManager.update(withTouch: touch, atLocation: location)
    }
}

extension ACDrawing.Manager: ACDrawingTouchManagerDelegate {
    func touchManager(_ touchManager: ACDrawing.TouchManager, touchUpdatedWithPoints points: [CGPoint]) {
        print("updated", points, "\n")
    }
    
    func touchManager(_ touchManager: ACDrawing.TouchManager, touchCompletedWithPoints points: [CGPoint]) {
        print("completed", points, "\n")
    }
}

extension ACDrawing.Manager: ACDrawingSegmentManagerDelegate {
    
}

extension ACDrawing.Manager: ACDrawingStrokeManagerDelegate {
    
}
