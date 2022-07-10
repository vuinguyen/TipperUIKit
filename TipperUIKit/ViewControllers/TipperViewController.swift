//
//  ViewController.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 1/29/22.
//

import UIKit
import SwiftUI

class TipperViewController: UIViewController {

    @IBOutlet var billAmountLabel: UILabel!
    @IBOutlet var billAmountTextField: UITextField!

    @IBOutlet var tipPercentLabel: UILabel!
    @IBOutlet var tipPercentSegmentedControl: UISegmentedControl!

    @IBOutlet var tipAmountTextLabel: UILabel!
    @IBOutlet var tipAmountValueLabel: UILabel!

    @IBOutlet var billTotalTextLabel: UILabel!
    @IBOutlet var billTotalValueLabel: UILabel!

    @IBOutlet var paidByLabel: UILabel!
    @IBOutlet var payButton: UIButton!

    @IBSegueAction func paymentView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: PaymentView(viewModel: tipperViewModel))
    }

    let tipperViewModel = TipperViewModel()
    let defaultBillAmount = Float(0.0)
    var previousBillAmount = Float(0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.delegate = self
        configureFonts()
        configureSegmentedControl()
        configureTextField()
    }

    override func viewWillAppear(_ animated: Bool) {
        updatePaySection()
    }

    private func configureFonts() {
        billAmountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        billAmountTextField.font = UIFont.preferredFont(forTextStyle: .title2)
        tipPercentLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        tipAmountTextLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        tipAmountValueLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        tipAmountValueLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        billTotalTextLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        billTotalValueLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        billTotalValueLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
    }

    private func configureSegmentedControl() {
        tipPercentSegmentedControl.addTarget(self, action: #selector(self.tipPercentChanged), for: .valueChanged)
    }

    // make Bill Amount text field focus by default
    private func configureTextField() {
        billAmountTextField.becomeFirstResponder()
    }

    @objc func tipPercentChanged() {
        switch tipPercentSegmentedControl.selectedSegmentIndex {
        case TipPercent.fifteen.controlIndex:
            tipperViewModel.tipPercent = .fifteen
        case TipPercent.twenty.controlIndex:
            tipperViewModel.tipPercent = .twenty
        case TipPercent.twentyfive.controlIndex:
            tipperViewModel.tipPercent = .twentyfive
        default:
            tipperViewModel.tipPercent = .fifteen
        }

        print("segment selected: \(tipperViewModel.tipPercent.description)")
        updateDisplay()
    }

    private func updateDisplay() {
        guard let billText = getBillText() else {
            return
        }
        let billAmount = tipperViewModel.getBillAmount(billText: billText)

        // calculate tip amount
        _ = tipperViewModel.getTipAmount(tipPercent: tipperViewModel.tipPercent, billAmount: billAmount)

        // display tip amount
        tipAmountValueLabel.text = tipperViewModel.getTipAmountStringFormatted(tipPercent: tipperViewModel.tipPercent, billAmount: billAmount)

        // calculate bill total
        _ = tipperViewModel.getBillTotal(tipPercent: tipperViewModel.tipPercent, billAmount: billAmount)

        // display bill total
        billTotalValueLabel.text = tipperViewModel.getBillTotalStringFormatted(tipPercent: tipperViewModel.tipPercent, billAmount: billAmount)

        // update pay state based on current billAmount
        tipperViewModel.payState = (billAmount == defaultBillAmount) ? .notpaid : .paying
        
        // store current billAmount as previous for next bill calculation
        previousBillAmount = billAmount

        updatePaySection()
    }

    private func clearDisplay() {
        tipAmountValueLabel.text = "$0.00"
        billTotalValueLabel.text = "$0.00"
    }

    // get bill amount value from textfield
    private func getBillText() -> String? {
        guard let billText = billAmountTextField.text,
        billText != "",
        billText != "." else {
            clearDisplay()
            return nil
        }
        return billText
    }

    private func updatePaySection() {
        payButton.isEnabled = tipperViewModel.payState == .paying ? true : false
        print("payState is: \(tipperViewModel.payState)")
        paidByLabel.isHidden = tipperViewModel.payState != .paid ? true : false

        guard tipperViewModel.paymentMethod != nil,
              let paymentDescription = tipperViewModel.paymentMethod?.description else {
            paidByLabel.text = "Paid By:"
            return
        }
        paidByLabel.text =  "Paid By: \(paymentDescription)"
    }
}

extension TipperViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("Typing: \(String(describing: textField.text))")
        guard let billText = getBillText() else {
            return
        }
        if tipperViewModel.getBillAmount(billText: billText) != previousBillAmount {
            updateDisplay()
        }
    }
}

