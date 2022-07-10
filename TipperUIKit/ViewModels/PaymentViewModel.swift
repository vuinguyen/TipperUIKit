//
//  PaymentViewModel.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 6/19/22.
//
import Foundation

enum PaymentMethod {
    case credit
    case applepay
    case cash

    var description: String {
        switch self {
        case .credit:
            return "Credit"
        case .applepay:
            return "Apple Pay"
        case .cash:
            return "Cash"
        }
    }
}
