//
//  CustomSearchBar.swift
//  OLX Feed Sample
//
//  Created by Gustavo Conde on 10/5/17.
//  Copyright © 2017 Gustavo Conde. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
        searchBarStyle = .prominent
        isTranslucent = false
        placeholder = "Find something"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let index = indexOfSearchFieldInSubviews() {
            // Access the search field
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
            
            // Set its frame.
            searchField.frame = CGRect(x: 5.0, y: 5.0, width: frame.size.width - 10.0, height: frame.size.height - 10.0)
            
            // Set the font and text color of the search field.
            searchField.font = UIFont(name: "Montserrat-Bold", size: 24)
            searchField.textColor = UIColor(rgb: 0xD2D2D2)
            searchField.leftViewMode = .never
            
            // Set the background color of the search field.
            searchField.backgroundColor = barTintColor
        }
        
        super.draw(rect)
        
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0..<searchBarView.subviews.count {
            if searchBarView.subviews[i] is UITextField {
                index = i
                break
            }
        }
        return index
    }

}
