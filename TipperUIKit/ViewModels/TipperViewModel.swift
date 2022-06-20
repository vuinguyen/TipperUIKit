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

    var image: String {
        switch self {
        case .fifteen:
            return "Image-15percent"
        case .twenty:
            return "Image-20percent"
        case .twentyfive:
            return "Image-25percent"
        }
    }
}

enum CalculatedAmountType: String {
    case tipAmount = "Tip Amount"
    case billTotal = "Bill Total"
}

enum PayState: String {
    case notpaid = "Not Paid"
    case paying = "Paying"
    case paid = "Paid"
}

class TipperViewModel: ObservableObject {
    @Published var tipPercent: TipPercent = .fifteen
    @Published var billAmount = Float(0.0)
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
            return formatter
        }()
    
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
    
    func getTipAmountStringFormatted(tipPercent: TipPercent, billAmount: Float) -> String {
        let tipAmount = getTipAmount(tipPercent: tipPercent, billAmount: billAmount)
        return formatter.string(for: tipAmount) ?? "$0.00"
    }

    func getBillTotal(tipPercent: TipPercent, billAmount: Float) -> Float {
        let tipAmount = getTipAmount(tipPercent: tipPercent, billAmount: billAmount)
        return billAmount + tipAmount
    }

    func getBillTotalString(billTotal: Float) -> String {
        // round to 2 decimal places for display
        let roundedValue = round(billTotal * 100) / 100.0
        return "$\(roundedValue)"
    }
    
    func getBillTotalStringFormatted(tipPercent: TipPercent, billAmount: Float) -> String {
        let billAmount = getBillTotal(tipPercent: tipPercent, billAmount: billAmount)
        return formatter.string(for: billAmount) ?? "$0.00"
    }
}
