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
    var defaultSelectedSegmentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = defaultSelectedSegmentIndex {
            imageSegmentedControl.selectedSegmentIndex = index
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
        imageSelector(self, didFinishSelecting: imageSelected.rawValue)
    }
}

extension GenerosityViewController: GenerosityViewControllerDelegate {
    func imageSelector(_ selector: GenerosityViewController, didFinishSelecting image: String) {
        // display the new image
        self.generosityImageView.image = UIImage(named: image)
    }
}
