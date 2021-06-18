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
    func GetMenuItemSections() -> [String] {
        
        var list: [String] = [];
        
        if (self.menuItems == nil) {
            return list;
        }
        
        for item in self.menuItems! {
            if (list.count == 0) {
                list.append(item.Category.Name);
            } else if (list[list.count-1] != item.Category.Name) {
                list.append(item.Category.Name);
            }
        }
        
        return list;
    }
    
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
            let sectionNames = self.GetMenuItemSections();
            if (sectionNames.count == 0) {
                return 0;
            }
            let categoryName = sectionNames[section];
            return self.menuItems?.filter{$0.Category.Name == categoryName}.count ?? 0
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.lstCategories) {
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierCategory, for: indexPath as IndexPath) as! CategoriesCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.lblName.text = self.categories![indexPath.row].Name
            
            return cell
        } else {
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierMenuItem, for: indexPath as IndexPath) as! MenuItemCell
            
            //cell.addDashedBorder();
            let categories = self.GetMenuItemSections();
            var cntItemsBefore = 0;
            for (index, element) in categories.enumerated() {
                
                if (index < indexPath.section) {
                    cntItemsBefore += self.menuItems?.filter{$0.Category.Name == element}.count ?? 0
                }
            }
            
            let item = self.menuItems![cntItemsBefore + indexPath.row];
            cell.item = item;
            let itemName = item.Item.Name
            let description = item.Item.Description
            let additives = " " + item.getAdditivesAllergiesSummary()
            
            let font:UIFont? = UIFont(name: "Helvetica", size:15)
            let fontSuper:UIFont? = UIFont(name: "Helvetica", size:11)
            let attString:NSMutableAttributedString = NSMutableAttributedString(string: itemName + additives, attributes: [.font:font!])
            attString.setAttributes([.font:fontSuper!,.baselineOffset:8], range: NSRange(location:itemName.count,length:additives.count))
            cell.lblName.attributedText = attString
            
            cell.lblDescription.text = description
            if (item.Item.Description.count == 0) {
            //    cell.stkView.removeArrangedSubview(cell.lblDescription);
            //    cell.lblDescription.text = "test"
            }
            
            
            cell.lstPrices.reloadData();
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
      // 1
      switch kind {
      // 2
      case UICollectionView.elementKindSectionHeader:
        
        
        if (collectionView == self.lstMenuItems) {
            
        // 3
        guard
          let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "\(MenuItemHeaderCell.self)",
            for: indexPath) as? MenuItemHeaderCell
          else {
            fatalError("Invalid view type")
        }

        if (self.menuItems != nil && self.menuItems!.count > indexPath.row) {
            let categoryName = self.GetMenuItemSections()[indexPath.section]
            headerView.lblCategoryName.text = categoryName
        }
        return headerView
        }
        assert(false, "Invalid element type")
      default:
        // 4
        assert(false, "Invalid element type")
      }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int   {
        
        if (collectionView == self.lstMenuItems) {
            let cnt = self.GetMenuItemSections().count;
            return cnt;
        }
        else {
            return 1
            
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
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell {
                cell.selectCell()
            }
        } else {
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell {
            cell.deselectCell()
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
