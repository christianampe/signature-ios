import Foundation

protocol ACDrawingManagerDelegate: class {
    func manager(_ manager: ACDrawing.Manager, didConstructSegment segment: ACDrawing.Segment)
}
