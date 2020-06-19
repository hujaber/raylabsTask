//
//  UserCell.swift
//  RayLabsTask
//
//  Created by Hussein Jaber on 6/19/20.
//  Copyright © 2020 Hussein Jaber. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    fileprivate lazy var userImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    fileprivate lazy var fullnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = UIColor(white: 0.15, alpha: 1)
        return lbl
    }()
    
    fileprivate lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 11, weight: .light)
        lbl.textColor = .init(white: 0.3, alpha: 1)
        return lbl
    }()
        
    private let cache: ImageCache = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        userImageView.layer.borderWidth = 0.6
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
    }
    
    private func setup() {
        selectionStyle = .none
        addSubviews()
    }
    
    fileprivate func addSubviews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(fullnameLabel)
        contentView.addSubview(emailLabel)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 16),
            userImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor, multiplier: 1),
            
            fullnameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: -10),
            fullnameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 15),
            fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            emailLabel.leadingAnchor.constraint(equalTo: fullnameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: fullnameLabel.trailingAnchor),
            emailLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 0),
            
            userImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func populate(with user: User) {
        downloadImage(with: user.imageURL)
        fullnameLabel.text = user.fullname
        emailLabel.text = user.email
    }
    
    private func downloadImage(with urlString: String?) {
        if let urlString = urlString {
            cache.fetchImage(urlString: urlString) { [weak self] (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.userImageView.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    

    
}


class UserCellWithLocation: UserCell {
    
    private lazy var mapKitView: MapKitView = {
        let mkv = MapKitView(frame: .zero)
        mkv.translatesAutoresizingMaskIntoConstraints = false
        mkv.layer.cornerRadius = 7
        mkv.clipsToBounds = true
        mkv.isScrollEnabled = false
        return mkv
    }()
    
    override func populate(with user: User) {
        super.populate(with: user)
        setupMapView(latitude: user.latitude!, longitude: user.longitude!)
    }
    
    private func setupMapView(latitude: Double, longitude: Double) {
        mapKitView.centerToCoordinates(latitude: latitude, longitude: longitude)
    }
    
    override func addSubviews() {
        contentView.addSubview(mapKitView)
        super.addSubviews()
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 16),
            userImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor, multiplier: 1),
            
            fullnameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: -10),
            fullnameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 15),
            fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            emailLabel.leadingAnchor.constraint(equalTo: fullnameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: fullnameLabel.trailingAnchor),
            emailLabel.topAnchor.constraint(equalTo: fullnameLabel.bottomAnchor, constant: 0),
            
            mapKitView.leadingAnchor.constraint(equalTo: fullnameLabel.leadingAnchor),
            mapKitView.trailingAnchor.constraint(equalTo: fullnameLabel.trailingAnchor),
            
            mapKitView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            mapKitView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mapKitView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.2)
            
        ])

    }
}
