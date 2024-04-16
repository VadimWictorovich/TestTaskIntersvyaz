//
//  DetailVC.swift
//  TestTaskIntersvyaz
//
//  Created by Вадим Игнатенко on 15.04.24.
//

import UIKit


final class DetailVC: UIViewController {
    
    // MARK: - Properties

    private var sharePhoto: [UIImage] = []
    var photo: PhotoModel?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Name"
        lab.textColor = .yellow
        lab.textAlignment = .center
        lab.numberOfLines = 0
        return lab
    }()
    
    private lazy var barItem: UIBarButtonItem = {
        let but = UIBarButtonItem(image:  UIImage(systemName: "square.and.arrow.up"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(sharedImage)
        )
        return but
    }()
    
    
    // MARK: - Lifecycle VC

    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityAnimation()
        setupUI()
        getPhoto()
        getTextLab()
    }
    
    
    // MARK: - Methods
    
    private func getPhoto() {
        guard let photo, let imagePath = photo.url, let url = URL(string: imagePath) else { return }
        NetworkService.downloadImage(from: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.stopActivityAnimation()
                guard let image else { return }
                self?.sharePhoto.append(image)
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
        navigationItem.rightBarButtonItem = barItem
        view.addSubview(imageView)
        view.addSubview(label)
        setupNSLayoutConstraints()
    }
    
    private func setupNSLayoutConstraints() {
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0).isActive = true

        
        NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: imageView, attribute: .bottomMargin, multiplier: 1.0, constant: 30.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 30.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: -30.0).isActive = true
    }
    
    
    @objc private func sharedImage() {
        let shareController = UIActivityViewController(activityItems: sharePhoto, applicationActivities: nil)
        present(shareController, animated: true)
    }
}
