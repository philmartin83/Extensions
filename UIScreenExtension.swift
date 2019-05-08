//
//  UIScreenExtension.swift
//  ConsentSDK
//
//  Created by Phil Martin on 19/10/2018.
//  Copyright © 2018 Tamoco. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen{
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 1920.0
    }
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}
