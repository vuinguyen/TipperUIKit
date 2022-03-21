//
//  ViewController.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 1/29/22.
//

import UIKit

class TipperViewController: UIViewController {

    @IBOutlet var billAmountLabel: UILabel!
    @IBOutlet var billAmountTextField: UITextField!

    @IBOutlet var tipPercentLabel: UILabel!
    @IBOutlet var tipPercentSegmentedControl: UISegmentedControl!

    @IBOutlet var tipAmountTextLabel: UILabel!
    @IBOutlet var tipAmountValueLabel: UILabel!

    @IBOutlet var billTotalTextLabel: UILabel!
    @IBOutlet var billTotalValueLabel: UILabel!

    var tipPercent: TipPercent = .fifteen
    let tipperViewModel = TipperViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.delegate = self
        configureFonts()
        configureSegmentedControl()
        configureTextField()
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
            tipPercent = .fifteen
        case TipPercent.twenty.controlIndex:
            tipPercent = .twenty
        case TipPercent.twentyfive.controlIndex:
            tipPercent = .twentyfive
        default:
            tipPercent = .fifteen
        }

        print("segment selected: \(tipPercent.description)")
        updateDisplay()
    }

    private func updateDisplay() {
        // get bill amount value from textfield
        guard let billText = billAmountTextField.text,
        billText != "",
        billText != "." else {
            clearDisplay()
            return
        }
        let billAmount = tipperViewModel.getBillAmount(billText: billText)

        // calculate tip amount
        _ = tipperViewModel.getTipAmount(tipPercent: tipPercent, billAmount: billAmount)

        // display tip amount
        tipAmountValueLabel.text = tipperViewModel.getTipAmountStringFormatted(tipPercent: tipPercent, billAmount: billAmount)

        // calculate bill total
        let billTotal = tipperViewModel.getBillTotal(tipPercent: tipPercent, billAmount: billAmount)

        // display bill total
        billTotalValueLabel.text = tipperViewModel.getBillTotalStringFormatted(tipPercent: tipPercent, billAmount: billTotal)
    }

    private func clearDisplay() {
        tipAmountValueLabel.text = "$0.00"
        billTotalValueLabel.text = "$0.00"
    }
}

extension TipperViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("Typing: \(String(describing: textField.text))")
        updateDisplay()
    }
}

