//
//  SearchCell.swift
//  OLX Feed Sample
//
//  Created by Gustavo Conde on 10/5/17.
//  Copyright © 2017 Gustavo Conde. All rights reserved.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    
    lazy var searchBar: UISearchBar = {
        let customSearchBar = CustomSearchBar()
        customSearchBar.barTintColor = UIColor(rgb: 0xF8F8F8)
        customSearchBar.tintColor = UIColor(rgb: 0xD2D2D2)
        customSearchBar.showsBookmarkButton = false
        customSearchBar.showsCancelButton = false
        self.contentView.addSubview(customSearchBar)
        return customSearchBar
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = contentView.bounds
    }
    
}
