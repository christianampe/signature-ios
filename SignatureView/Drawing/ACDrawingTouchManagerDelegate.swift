import UIKit

protocol ACDrawingTouchManagerDelegate: class {
    func touchManager(_ touchManager: ACDrawing.TouchManager, touchStartedAtPoint point: CGPoint)
    func touchManager(_ touchManager: ACDrawing.TouchManager, touchUpdatedWithPoint point: CGPoint)
    func touchManager(_ touchManager: ACDrawing.TouchManager, touchCompletedAtPoint point: CGPoint)
}
