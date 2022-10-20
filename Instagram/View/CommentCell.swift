//
//  CommentCell.swift
//  Instagram
//
//  Created by Andrey Kryukov on 12.10.2022.
//

import UIKit

final class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: CommentViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let commentLabel = UILabel()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        
        commentLabel.numberOfLines = 0
        addSubview(commentLabel)
        commentLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        commentLabel.anchor(right: rightAnchor, paddingRight: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
        commentLabel.attributedText = viewModel.commentLabelText()
    }
}
