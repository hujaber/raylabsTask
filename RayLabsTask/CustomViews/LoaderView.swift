//
//  LoaderView.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/18/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var loadingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        lbl.textAlignment = .center
        lbl.text = "Loading.."
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    private func setup() {
        backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(white: 0.94, alpha: 1.0).cgColor
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(loadingLabel)
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8),
            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            loadingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
}

protocol Loads: AnyObject {
    var loader: LoaderView! { get set }
}

extension Loads where Self: UIViewController {
    func showLoader() {
        if loader == nil {
            loader = LoaderView()
            loader.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
        loader.removeFromSuperview()
    }
}

