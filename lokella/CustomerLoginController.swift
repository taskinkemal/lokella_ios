//
//  FirstViewController.swift
//  lokella
//
//  Created by Kemal Taskin on 09.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import UIKit

class CustomerLoginController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnSubmit.addTarget(self, action: #selector(CustomerLoginController.btnSubmitClicked(_:)), for: .touchUpInside)

    }
    @objc func btnSubmitClicked(_ sender: UIButton) {
        // your code goes here
        
        let email = txtEmail.text!;
        let firstName = txtFirstName.text!;
        let lastName = txtLastName.text!;
        let phoneNumber = txtPhoneNumber.text!;
        let deviceId = UIDevice.current.identifierForVendor!.uuidString;
        
        let customer = CustomerLogin.init(
            Email: email,
            FirstName: firstName,
            LastName: lastName,
            PhoneNumber: phoneNumber,
            DeviceId: deviceId);
        
        DataStore.SetIsCustomerVerified(isVerified: false);
        DataStore.SetCustomer(customerLogin: customer);
        
        HttpRequest.send(
            url: "Customers",
            method: "POST",
            data: customer,
            cbSuccess: CallbackSuccessPostUser,
            cbError: CallbackError);
        

    }
    
    func CallbackError(statusCode:Int, message: String)
    {

    }
    
    func CallbackSuccessPostUser(result:JsonResult<Int>)
    {
        let alert = UIAlertController(title: "Alert", message: "Welcome " + String(result.value), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

