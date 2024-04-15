//
//  DetailVC.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import UIKit

final class DetailVC: UIViewController {
    
    var photo: PhotoModel?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "defaultImage.png")
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Name"
        return lab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPhoto()
        getTextLab()
    }
    
    private func getPhoto() {
        guard let photo,
              let imagePath = photo.url,
              let url = URL(string: imagePath) else { return }
        NetworkService.downloadImage(from: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    private func getTextLab() {
        guard let photo, let text = photo.title else { return }
        DispatchQueue.main.async { [weak self] in
            self?.label.text = text
        }
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(label)
        setupNSLayoutConstraints()
    }
    
    private func setupNSLayoutConstraints() {
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true

        
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .topMargin, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerXWithinMargins, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
}
