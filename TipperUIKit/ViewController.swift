//
//  ViewController.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 1/29/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var billAmountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setFonts()
    }

    private func setFonts() {
        billAmountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}

