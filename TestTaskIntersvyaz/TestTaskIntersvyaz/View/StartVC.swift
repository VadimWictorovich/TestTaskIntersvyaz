//
//  StartVC.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import UIKit


final class StartVC: UIViewController {
    
    // MARK: - Properties

    private lazy var startButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Start", for: .normal)
        but.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        but.setTitleColor(.black, for: .normal)
        but.layer.cornerRadius = 10
        but.addTarget(nil, action: #selector(openGaleryCVC), for: .touchUpInside)
        return but
    }()
    

    // MARK: - Lifecycle VC

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Methods

    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.addSubview(startButton)
        setupNSLayoutConstraints()
    }
    
    private func setupNSLayoutConstraints() {
        NSLayoutConstraint(item: startButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -50.0).isActive = true
        NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerXWithinMargins, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0).isActive = true
    }
    
    @objc private func openGaleryCVC() {
        startActivityAnimation()
        let vc = GalleryPhotosCollectionVC(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
