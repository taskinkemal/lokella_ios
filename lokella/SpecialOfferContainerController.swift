//
//  SpecialOfferContainerController.swift
//  lokella
//
//  Created by meisinger06 on 22.06.21.
//  Copyright © 2021 Kelpersegg. All rights reserved.
//

import UIKit

class SpecialOfferContainerController : UIViewController, UIScrollViewDelegate {
    
    let businessId: Int = 1;
    
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();

        self.view.backgroundColor = nil;
        scrView.backgroundColor = nil;
        vContent.backgroundColor = UIColor(white: 1, alpha: 0.8);
        scrView.delegate = self;
        
        btnClose.addTarget(self, action: #selector(SpecialOfferContainerController.btnCloseClicked(_:)), for: .touchUpInside)

        
        HttpRequest.send(
            url: "SpecialOffers/" + String(self.businessId),
            method: "GET",
            data: nil,
            cbSuccess: CallbackSuccessGetSpecialOffers,
            cbError: CallbackError);
    }
    
    
    @objc func btnCloseClicked(_ sender: UIButton) {
        
        print("here")
            self.performSegue(withIdentifier: "sgUnwindSpecialOffers", sender: nil);
    }
    
    func CallbackError(statusCode:Int, message: String)
    {
        print(message);
    }
    
    func CallbackSuccessGetSpecialOffers(result:[SpecialOffer])
    {
        
        DispatchQueue.main.sync {
            scrView.contentSize = CGSize(width: view.frame.width * CGFloat(result.count), height: view.frame.height)
            pageControl.numberOfPages = result.count
            pageControl.currentPage = 0
            view.bringSubviewToFront(pageControl)
            view.bringSubviewToFront(btnClose)
        }
        
        for i in 0..<result.count {
            
            DispatchQueue.main.sync {
                
            // calcuate the horizontal offset
            let offset = i == 0 ? 0 : (CGFloat(i) * self.view.bounds.width)
            
            
            // create a UIImageView
            let imgView = UIImageView(frame: CGRect(x: offset + 16, y: 0, width: vContent.bounds.width - 32, height: vContent.bounds.height))
                
                imgView.backgroundColor = nil;
            
            let url = URL(string: Constants.serviceEndpoint + "Files/" + String(result[i].FileId));
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            imgView.image = UIImage(data: data!)
            // handle the overflow
            imgView.clipsToBounds = true
                
            // handle the contentMode
                imgView.contentMode = .scaleToFill
            // add the UIImageView to the UIScrollView
            
                
                vContent.addSubview(imgView)
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let x = scrView.contentOffset.x
            let w = scrView.bounds.size.width
            pageControl.currentPage = Int(ceil(x/w))
    }
}
