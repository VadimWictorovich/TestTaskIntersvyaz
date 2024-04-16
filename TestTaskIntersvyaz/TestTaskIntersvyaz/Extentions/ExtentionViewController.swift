//
//  ExtentionViewController.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 16.04.24.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

extension UIViewController: NVActivityIndicatorViewable {
    
    func startActivityAnimation() {
        startAnimating(message: "Загрузка...", type: .squareSpin, color: .white, textColor: .white)
    }
    
    func stopActivityAnimation() {
        stopAnimating()
    }
}
