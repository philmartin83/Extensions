//
//  DoubleExtension.swift
//  MotionTraining
//
//  Created by Phil Martin on 07/05/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
