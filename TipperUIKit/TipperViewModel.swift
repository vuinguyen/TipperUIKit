//
//  TipperViewModel.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 1/30/22.
//

import Foundation

protocol segmentedControl {
    var description: String { get }
    var controlIndex: Int { get }
}

enum TipPercent: Float, segmentedControl {
    case fifteen = 0.15
    case twenty = 0.20
    case twentyfive = 0.25

    var description: String {
        switch self {
        case .fifteen:
            return "15%"
        case .twenty:
            return "20%"
        case .twentyfive:
            return "25%"
        }
    }

    var controlIndex: Int {
        switch self {
        case .fifteen:
            return 0
        case .twenty:
            return 1
        case .twentyfive:
            return 2
        }
    }
}


class TipperViewModel {

}
