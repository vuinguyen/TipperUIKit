//
//  GenerosityViewController.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 4/11/22.
//

import UIKit

protocol GenerosityViewControllerDelegate {
    func imageSelector(_ selector: GenerosityViewController, didFinishSelecting image: String)
}

class GenerosityViewController: UIViewController {

    @IBOutlet weak var generosityImageView: UIImageView!
    @IBOutlet weak var imageSegmentedControl: UISegmentedControl!
    
    var imageSelected = ImageSelected.one
    var delegate: GenerosityViewControllerDelegate?
    var tipPercentage: TipPercent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        if let percentage = tipPercentage {
            imageSegmentedControl.selectedSegmentIndex = percentage.controlIndex
            imageSelectedChanged()
        }
        configureSegmentedControl()
    }
    
    private func configureSegmentedControl() {
        imageSegmentedControl.addTarget(self, action: #selector(self.imageSelectedChanged), for: .valueChanged)
    }
    
    @objc func imageSelectedChanged() {
        switch imageSegmentedControl.selectedSegmentIndex {
        case ImageSelected.one.controlIndex:
            imageSelected = ImageSelected.one
        case ImageSelected.two.controlIndex:
            imageSelected = ImageSelected.two
        case ImageSelected.three.controlIndex:
            imageSelected = ImageSelected.three
        default:
            imageSelected = ImageSelected.one
        }
        delegate?.imageSelector(self, didFinishSelecting: imageSelected.rawValue)
    }
}

extension GenerosityViewController: GenerosityViewControllerDelegate {
    func imageSelector(_ selector: GenerosityViewController, didFinishSelecting image: String) {
        // display the new image
        self.generosityImageView.image = UIImage(named: image)
    }
}
