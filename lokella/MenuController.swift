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
    
    let reuseIdentifier = "categoryCell" // also enter this string as the cell identifier in the storyboard
    var items: [MenuCategory]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lstCategories.backgroundColor = UIColor.brown

        
        HttpRequest.send(
            url: "Businesses/" + "LokellaBusinessId_1",
            method: "GET",
            data: nil,
            cbSuccess: CallbackSuccessGetBusiness,
            cbError: CallbackError);
        
        
        HttpRequest.send(
            url: "Menu/Items/category/3/",
            method: "GET",
            data: nil,
            cbSuccess: CallbackSuccessGetMenuItems,
            cbError: CallbackError);
    }
    
    func CallbackError(statusCode:Int, message: String)
    {
        print(message);
    }
    
    
    func CallbackSuccessGetMenuItems(result:[MenuItemTo])
    {
        print(result.count);
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
            self.items = result;
            lstCategories.reloadData();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CategoriesCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.lblName.text = self.items![indexPath.row].Name // The row value is the same as the index of the desired text within the array.
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellWidth : CGFloat = 165.0
        
        let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
        let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
