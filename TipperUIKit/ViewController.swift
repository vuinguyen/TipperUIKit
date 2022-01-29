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


    override func viewDidLoad() {
        super.viewDidLoad()

        setFonts()
    }

    private func setFonts() {
        billAmountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}

