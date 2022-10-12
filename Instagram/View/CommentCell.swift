//
//  CommentCell.swift
//  Instagram
//
//  Created by Andrey Kryukov on 12.10.2022.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "name ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "Some comment", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedString
        return label
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        
        addSubview(commentLabel)
        commentLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

}
