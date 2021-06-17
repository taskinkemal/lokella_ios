//
//  MenuController.swift
//  lokella
//
//  Created by Kemal Taskin on 13.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgLogo2: UIImageView!
    @IBOutlet weak var lstCategories: UICollectionView!
    @IBOutlet weak var lstMenuItems: UICollectionView!
    
    let cellIdentifierCategory = "categoryCell";
    let cellIdentifierMenuItem = "menuItemCell";
    
    var categories: [MenuCategory]? = nil
    var menuItems: [MenuItemTo]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lstMenuItems.backgroundColor = UIColor.blue

        HttpRequest.send(
            url: "Businesses/" + "LokellaBusinessId_1",
            method: "GET",
            data: nil,
            cbSuccess: CallbackSuccessGetBusiness,
            cbError: CallbackError);
    }
    
    func CallbackError(statusCode:Int, message: String)
    {
        print(message);
    }
    
    func CallbackSuccessGetMenuItems(result:[MenuItemTo])
    {
        DispatchQueue.main.sync {
            self.menuItems = result;
            lstMenuItems.reloadData();
        }
    }
    
    func CallbackSuccessGetBusiness(result:Business)
    {
        let url = URL(string: Constants.serviceEndpoint + "Files/" + String(result.LogoId));
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.sync {
            lblName.text = result.Name
            imgLogo2.image = UIImage(data: data!)
        }
        
        HttpRequest.send(
            url: "Menu/Businesses/" + String(result.Id),
            method: "GET",
            data: nil,
            cbSuccess: CallbackSuccessGetCategories,
            cbError: CallbackError);
    }
    
    func CallbackSuccessGetCategories(result:[MenuCategory])
    {
        DispatchQueue.main.sync {
            self.categories = result;
            lstCategories.reloadData();
        }
        
        if (result.count > 0) {
            
            fetchMenuItems(categoryId: result[0].Id);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.lstCategories) {
            return self.categories?.count ?? 0
        } else {
            return self.menuItems?.count ?? 0
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.lstCategories) {
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierCategory, for: indexPath as IndexPath) as! CategoriesCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.lblName.text = self.categories![indexPath.row].Name // The row value is the same as the index of the desired text within the array.
            //cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
            
            return cell
        } else {
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierMenuItem, for: indexPath as IndexPath) as! MenuItemCell
            
            //cell.addDashedBorder();
            
            let item = self.menuItems![indexPath.row];
            cell.item = item;
            let itemName = item.Item.Name
            let additives = " " + item.getAdditivesAllergiesSummary()
            
            let font:UIFont? = UIFont(name: "Helvetica", size:15)
            let fontSuper:UIFont? = UIFont(name: "Helvetica", size:11)
            let attString:NSMutableAttributedString = NSMutableAttributedString(string: itemName + additives, attributes: [.font:font!])
            attString.setAttributes([.font:fontSuper!,.baselineOffset:8], range: NSRange(location:itemName.count,length:additives.count))
            cell.lblName.attributedText = attString
            
            cell.lblDescription.text = item.Item.Description
            if (item.Item.Description.count == 0) {
                cell.stkView.removeArrangedSubview(cell.lblDescription);
            }
            cell.lstPrices.reloadData();
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if (collectionView == self.lstCategories) {
            
            let cellWidth : CGFloat = 165.0
            
            let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
            let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
            
            return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets);
        } else {
            return UIEdgeInsets.init();
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!");
        
        if (collectionView == self.lstCategories) {
            
            let categoryId = categories![indexPath.item].Id;
            
            fetchMenuItems(categoryId: categoryId);
        } else {
            
        }
    }
    
    func fetchMenuItems(categoryId: Int) {
        
        HttpRequest.send(
            url: "Menu/Items/category/" + String(categoryId),
            method: "GET",
            data: nil,
            cbSuccess: CallbackSuccessGetMenuItems,
            cbError: CallbackError);
    }
}
