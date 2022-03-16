//
//  TipperUIKitTests.swift
//  TipperUIKitTests
//
//  Created by Vui Nguyen on 1/29/22.
//

import XCTest
@testable import TipperUIKit

class TipperUIKitTests: XCTestCase {

    let tipperViewModel = TipperViewModel()

    func testGetBillAmount() throws {
        let billText = "10.50"
        let billAmount = Float(10.50)
        XCTAssertEqual(tipperViewModel.getBillAmount(billText: billText), billAmount)
    }

    func testGetTipAmount() {
        let tipPercent = TipPercent.fifteen
        let billAmount = Float(10)
        let tipAmount = Float(1.5)
        XCTAssertEqual(tipperViewModel.getTipAmount(tipPercent: tipPercent, billAmount: billAmount), tipAmount)
    }

    func testGetTipAmountString() {
        let tipAmount = Float(1.5)
        let tipAmountString = "$1.5"
        XCTAssertEqual(tipperViewModel.getTipAmountString(tipAmount: tipAmount), tipAmountString)
    }

    func testGetTipAmountStringFormatted() {
        let tipPercent = TipPercent.twentyfive
        let billAmount = Float(23.0)
        XCTAssertEqual(tipperViewModel.getTipAmountStringFormatted(tipPercent: tipPercent, billAmount: billAmount), "$5.75")
    }
    
    func testGetBillTotal() {
        let tipPercent = TipPercent.twenty
        let billAmount = Float(20)
        let billTotal = Float(24.0)
        XCTAssertEqual(tipperViewModel.getBillTotal(tipPercent: tipPercent, billAmount: billAmount), billTotal)
    }

    func testGetBillTotalString() {
        let billTotal = Float(24.0)
        let billTotalString = "$24.0"
        XCTAssertEqual(tipperViewModel.getBillTotalString(billTotal: billTotal), billTotalString)
    }

    func testGetBillTotalStringFormatted() {
        let tipPercent = TipPercent.twentyfive
        let billAmount = Float(23.0)
        XCTAssertEqual(tipperViewModel.getBillTotalStringFormatted(tipPercent: tipPercent, billAmount: billAmount), "$28.75")
    }
}
