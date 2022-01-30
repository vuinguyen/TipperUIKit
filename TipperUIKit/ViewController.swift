//
//  ViewController.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 1/29/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var billAmountLabel: UILabel!
    @IBOutlet var billAmountTextField: UITextField!

    @IBOutlet var tipPercentLabel: UILabel!
    @IBOutlet var tipPercentSegmentControl: UISegmentedControl!

    @IBOutlet var tipAmountTextLabel: UILabel!
    @IBOutlet var tipAmountValueLabel: UILabel!

    @IBOutlet var billTotalTextLabel: UILabel!
    @IBOutlet var billTotalValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setFonts()
        configureTextField()
        billAmountTextField.delegate = self
    }

    private func setFonts() {
        billAmountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        billAmountTextField.font = UIFont.preferredFont(forTextStyle: .title2)
        tipPercentLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        tipAmountTextLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        tipAmountValueLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        billTotalTextLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        billTotalValueLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    }

    private func configureTextField() {
        billAmountTextField.becomeFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {

}

