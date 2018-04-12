import Foundation

infix operator ** { associativity left precedence 160 }

public func ** (left: Double, right: Double) -> Double {
  return pow(left, right)
}

