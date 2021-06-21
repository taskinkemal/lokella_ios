//
//  ProfileController.swift
//  lokella
//
//  Created by meisinger06 on 18.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import UIKit

class ProfileController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var lstProfile: UICollectionView!
    
    var items: [ProfileItem] = [];
    let cellIdentifier = "profileCell";
    
    @IBOutlet weak var btnDeleteAccount: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnLogout.addTarget(self, action: #selector(ProfileController.btnLogoutClicked(_:)), for: .touchUpInside);
        
        let customer = DataStore.GetCustomer();
        
        items.append(ProfileItem.init(Label: "Vorname", Value: customer?.FirstName ?? ""));
        items.append(ProfileItem.init(Label: "Nachname", Value: customer?.LastName ?? ""));
        items.append(ProfileItem.init(Label: "Email", Value: customer?.Email ?? ""));
        items.append(ProfileItem.init(Label: "Phonenummer", Value: customer?.PhoneNumber ?? ""));
        
        lstProfile.reloadData();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.items.count;
    }
   
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! ProfileCell
        
        cell.lblLabel.text = self.items[indexPath.row].Label;
        cell.lblValue.text = self.items[indexPath.row].Value;
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!");
    }
    
    @objc func btnLogoutClicked(_ sender: UIButton) {
     
        DataStore.SetCustomer(customer: nil);
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginScreen = storyBoard.instantiateViewController(withIdentifier: "CustomerLoginController")
            appDelegate.window?.rootViewController = loginScreen
        }
        
        performSegue(withIdentifier: "sgLogout", sender: nil);

    }
}

