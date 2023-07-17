//
//  extensionFileForCalculation.swift
//  HW#30_calculator
//
//  Created by Dawei Hao on 2023/7/14.
//

import Foundation

extension Double {
    //四捨五入
    func rounding(toDecimal decimal: Int) -> Double {
        let numOfDigits = pow(10.0, Double(decimal))
        return (self * numOfDigits).rounded(.toNearestOrAwayFromZero) / numOfDigits
    }
    //無條件捨去
    func floor(toInteger integer: Int) -> Int {
        let integer = integer - 1
        let numberOfDigits = pow(10.0, Double(integer))
        return Int((self / numberOfDigits).rounded(.towardZero) * numberOfDigits)
    }
}
