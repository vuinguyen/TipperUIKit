//
//  GenerosityViewModel.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 4/13/22.
//

import Foundation

enum ImageSelected: String, segmentedControl {
    case one = "image-1"
    case two = "image-2"
    case three = "image-3"
    
    var description: String {
        switch self {
        case .one:
            return "Image 1"
        case .two:
            return "Image 2"
        case .three:
            return "Image 3"
        }
    }
    
    var controlIndex: Int {
        switch self {
        case .one:
            return 0
        case .two:
            return 1
        case .three:
            return 2
        }
    }
    
}
