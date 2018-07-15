//
//  ViewController.swift
//  Speedometer
//
//  Created by Mark DiFranco on 4/3/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import UIKit
import CoreLocation
import SwinjectStoryboard
import Swinject

private let maxDisplayableSpeed: CLLocationSpeed = 40 // m/s

class ViewController: UIViewController {

    @IBOutlet var speedLabels: [UILabel]!
    @IBOutlet weak var speedViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var colorableViews: [UIView]!
    
    var speedProvider: SPDLocationSpeedProvider! {
        didSet {
            speedProvider.delegate = self
        }
    }
    
    var speedChecker: SPDLocationSpeedChecker! {
        didSet {
            speedChecker.delegate = self
        }
    }
    
    @IBAction func didTapMaxSpeed(_ sender: Any) {
        let alertController = UIAlertController(title: "Pick max speed!", message: "You will be alerted when reach max speed", preferredStyle: .alert)
        alertController.addTextField { [weak self] (textField) in
            textField.keyboardType = .numberPad
            if let maxSpeed = self?.speedChecker.maximumSpeed {
                textField.text = String(format: "%.0f", maxSpeed.asKMH)
            }
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            guard let text = alertController.textFields?.first?.text else { return }
            guard let maxSpeed = Double(text) else { return }
            
            self?.speedChecker.maximumSpeed = maxSpeed.asMPS
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        for label in speedLabels {
            label.text = "0"
        }
        speedViewHeightConstraint.constant = 0
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

extension ViewController: SPDLocationSpeedProviderDelegate {
    func didUpdate(speed: CLLocationSpeed) {
        for label in speedLabels {
            label.text = String(format: "%.0f", speed.asKMH)
        }
        view.layoutIfNeeded()
        
        let maxHeight = view.bounds.height
        speedViewHeightConstraint.constant = maxHeight * CGFloat(speed / maxDisplayableSpeed)
        
        UIView.animate(withDuration: 1.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

extension ViewController: SPDLocationSpeedCheckerDelegate {
    func exceedingMaximumSpeedChanged(for speedChecker: SPDLocationSpeedChecker) {
        let color: UIColor = speedChecker.isExceedingMaximumSpeed ? .speedometerRed : .speedometarBlue
        UIView.animate(withDuration: 1.0) { [weak self] in
            for view in self?.colorableViews ?? [] {
                if let label = view as? UILabel {
                    label.textColor = color
                } else if let button = view as? UIButton {
                    button.setTitleColor(color, for: .normal)
                } else {
                    view.backgroundColor = color
                }
            }
        }
    }
}

extension CLLocationSpeed {
    var asKMH: Double {
        return self * 3.6
    }
}

extension UIColor {
    static let speedometerRed = UIColor(displayP3Red: 255/255, green: 85/255, blue: 0/255, alpha: 1)
    static let speedometarBlue = UIColor(displayP3Red: 0/255, green: 0/255, blue: 128/255, alpha: 1)
}

extension Double {
    var asMPS: CLLocationSpeed {
        return self / 3.6
    }
}


class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.storyboardInitCompleted(ViewController.self) { (reslover, controller) in
            controller.speedProvider = reslover.resolve(SPDLocationSpeedProvider.self)!
            controller.speedChecker = reslover.resolve(SPDLocationSpeedChecker.self)!
        }
    }
}
