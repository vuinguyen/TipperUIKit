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
    func getBillAmount(billText: String = "") -> Float {
        var billAmount = billText
        let nonNumerals: Set<Character> = ["$"]
        billAmount.removeAll(where: { nonNumerals.contains($0) })
        return NSString(string: billAmount).floatValue
    }

    func getTipAmount(tipPercent: TipPercent, billAmount: Float) -> Float {
        return billAmount * tipPercent.rawValue
    }

    func getTipAmountString(tipAmount: Float) -> String {
        // round to 2 decimal places for display
        let roundedValue = round(tipAmount * 100) / 100.0
        return "$\(roundedValue)"
    }

    func getBillTotal(tipPercent: TipPercent, billAmount: Float) -> Float {
        let tipAmount = getTipAmount(tipPercent: tipPercent, billAmount: billAmount)
        return billAmount + tipAmount
    }

    func getBillTotalString(billAmount: Float) -> String {
        // round to 2 decimal places for display
        let roundedValue = round(billAmount * 100) / 100.0
        return "$\(roundedValue)"
    }
}
