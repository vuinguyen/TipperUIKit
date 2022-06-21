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

    @IBOutlet var paidByLabel: UILabel!
    @IBOutlet var payButton: UIButton!

    // Use SwiftUI view to display the tip amount
    @IBSegueAction func tipAmountView(_ coder: NSCoder) -> UIViewController? {
        UIHostingController(coder: coder, rootView: CalculatedAmountView(viewModel: tipperViewModel, calculatedAmountType: CalculatedAmountType.tipAmount))
    }
    
    // Use SwiftUI view to display the bill total
    @IBSegueAction func billTotalView(_ coder: NSCoder) -> UIViewController? {
        UIHostingController(coder: coder, rootView: CalculatedAmountView(viewModel: tipperViewModel, calculatedAmountType: CalculatedAmountType.billTotal))
    }

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

    // Once tipPercent and billAmount are updated in tipperViewModel,
    // that will automatically update the Tip Amount and Bill Total displays
    // through CalculatedAmountView
    private func updateDisplay() {
        guard let billText = getBillText() else {
            return
        }

        tipperViewModel.billAmount = tipperViewModel.getBillAmount(billText: billText)
        tipperViewModel.payState =
            (tipperViewModel.billAmount == defaultBillAmount) ? .notpaid : .paying
        previousBillAmount = tipperViewModel.getBillAmount(billText: billText)
        updatePaySection()
    }

    private func getBillText() -> String? {
        guard let billText = billAmountTextField.text,
           billText != "",
           billText != "." else {
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

