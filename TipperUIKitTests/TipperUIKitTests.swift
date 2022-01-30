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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
