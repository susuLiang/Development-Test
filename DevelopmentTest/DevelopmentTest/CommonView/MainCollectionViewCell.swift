//
//  MainCollectionViewCell.swift
//  DevelopmentTest
//
//  Created by Hsu Ming Ku on 2020/3/18.
//  Copyright © 2020 Shu Wei Liang. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBAction func tapLikeButton(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellContent(post: Post) {
        self.titleLabel.text = post.title
        self.userNameLabel.text = post.user.name
        self.likeCountLabel.text = "\(post.likes)"
        
    }

}
