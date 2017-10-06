//
//  PostViewCell.swift
//  OLX Feed Sample
//
//  Created by Gustavo Conde on 10/5/17.
//  Copyright © 2017 Gustavo Conde. All rights reserved.
//

import UIKit
import IGListKit
import AlamofireImage

final class PostViewCell: UICollectionViewCell {
    static let nibName = "PostViewCell"
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postCreationDateLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    func config(with post: Post) {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.description
        if let url = URL(string: post.carPicture) {
            carImageView.af_setImage(withURL: url)
        }
    }
    
}

/*extension PostViewCell: ListBindable {
    
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? String else { return }
        postTitleLabel.text = viewModel
    }
    
}*/
