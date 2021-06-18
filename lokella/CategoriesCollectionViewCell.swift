//
//  CategoriesCollectionViewCell.swift
//  lokella
//
//  Created by Kemal Taskin on 13.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import UIKit
class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    
    func selectCell() {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: lblName.text!, attributes: underlineAttribute)
        lblName.attributedText = underlineAttributedString
    }
    
    
    func deselectCell() {
        let underlineAttributedString = NSAttributedString(string: lblName.text!)
        lblName.attributedText = underlineAttributedString
    }
}
