//
//  MenuItemCell.swift
//  lokella
//
//  Created by Kemal Taskin on 15.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import UIKit
class MenuItemCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var item: MenuItemTo? = nil;
    var fontColor: String = "";
    
    @IBOutlet weak var stkView: UIStackView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lstPrices: UICollectionView!
    @IBOutlet weak var lstTags: UICollectionView!
    
    var cellIdentifierPrice = "priceCell"
    var cellIdentifierTag = "tagCell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.lstPrices) {
            return self.item?.Prices.count ?? 0;
        } else {
            return self.item?.Tags.count ?? 0;
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.lstPrices) {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierPrice, for: indexPath as IndexPath) as! PriceCell
            
            let price = self.item!.Prices[indexPath.row];
            
            cell.lblPrice.textColor = UIColorExtensions.fromHex(hex: self.fontColor);
            cell.lblPrice.text = price.toString();
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierTag, for: indexPath as IndexPath) as! TagCell
            
            let tagImageMap:[String] = ["bio", "regional", "spicy", "vegan"];
            let index = (Int(self.item!.Tags[indexPath.row].Id));
            //DispatchQueue.main.sync {
                cell.imgTag.image = UIImage(named: tagImageMap[index-1]);
            //}
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!");
        
    }
    
    /*
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //label.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        
        
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        let h1 = stkView.frame.height;
        let h2 = lstPrices.frame.height;
        layoutAttributes.bounds.size.height = (h1 > h2) ? h1 : h2;
        return layoutAttributes
    }
    */
}
