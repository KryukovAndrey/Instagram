//
//  ProfileHeader.swift
//  Instagram
//
//  Created by Andrey Kryukov on 30.09.2022.
//

import UIKit
import Kingfisher

protocol ProfileHeaderDelegate: class {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit profile", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleProfileFollowTapped), for: .touchUpInside)
        return button
    }()

    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [postLabel, followersLabel, followingLabel])
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = UIColor.lightGray
        
        let bottomDivider = UIView()
        topDivider.backgroundColor = UIColor.lightGray
        
        let buttomStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttomStack.distribution = .fillEqually
        
        addSubview(topDivider)
        addSubview(bottomDivider)
        addSubview(buttomStack)
        
        buttomStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        topDivider.anchor(top: buttomStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        bottomDivider.anchor(top: buttomStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handleProfileFollowTapped() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.fullName
        let url = URL(string: viewModel.profileImage)
        profileImageView.kf.setImage(with: url)
        
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
        
        postLabel.attributedText = viewModel.numbersOfPosts
        followersLabel.attributedText = viewModel.numbersOfFollowers
        followingLabel.attributedText = viewModel.numbersOfFollowing
    }
}
