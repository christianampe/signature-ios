import UIKit

extension ACDrawing {
    enum Math {}
}

// MARK: - CGPoint Operations

extension ACDrawing.Math {
    
    /// Averages one point with another.
    ///
    /// - Parameter p0: The first point to average against.
    /// - Parameter p1: The second point to average against.
    ///
    /// - Returns: A point with an x and y equal to the average of this and the given point's x and y.
    static func average(_ p0: CGPoint, _ p1: CGPoint) -> CGPoint {
        return CGPoint(x: (p0.x + p1.x) * 0.5, y: (p0.y + p1.y) * 0.5)
    }
    
    /// Calculates the difference in x and y between two points.
    ///
    /// - Parameter p0: The point to calculate the difference from.
    /// - Parameter p1: The point to calculate the difference to.
    ///
    /// - Returns: A point with an x and y equal to the difference between this and the given point's x and y.
    static func differential(_ p0: CGPoint, _ p1: CGPoint) -> CGPoint {
        return CGPoint(x: p1.x - p0.x, y: p1.y - p0.y)
    }
    
    /// Calculates the distance between two points.
    ///
    /// - Parameter p0: The point to calculate the distance from.
    /// - Parameter p1: The point to calculate the distance to.
    ///
    /// - Returns: A CGFloat of the distance between the points.
    static func distance(_ p0: CGPoint, _ p1: CGPoint) -> CGFloat {
        return hypotenuse(differential(p0, p1))
    }
    
    /// Calculates the hypotenuse of the x and y component of a point.
    ///
    /// - Parameter p: The point to calculate the hypotenuse of.
    ///
    /// - Returns: A CGFloat for the hypotenuse of the point.
    static func hypotenuse(_ p: CGPoint) -> CGFloat {
        return sqrt(p.x * p.x + p.y * p.y)
    }
}
