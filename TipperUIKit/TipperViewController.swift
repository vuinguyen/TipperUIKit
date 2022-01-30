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
        tipAmountValueLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        billTotalTextLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        billTotalValueLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    }

    private func configureSegmentedControl() {
        tipPercentSegmentedControl.addTarget(self, action: #selector(self.tipPercentChanged), for: .valueChanged)
    }

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
        calculateBillTotal()
    }

    private func updateDisplay() {
        // grab tip percentage
        // grab bill amount
        // calculate tip amount
        // display tip amount
        // calculate bill total
        // display bill total
    }

    private func calculateBillTotal() {
        
    }
}

extension TipperViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("Typing: \(String(describing: textField.text))")
    }
}

