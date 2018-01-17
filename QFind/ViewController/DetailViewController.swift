//
//  DetailViewController.swift
//  QFind
//
//  Created by Exalture on 16/01/18.
//  Copyright © 2018 QFind. All rights reserved.
//

import UIKit
import MessageUI
class DetailViewController: UIViewController,BottomProtocol,MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var detailBottomBar: BottomBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
       
    }
    func initialSetUp()
    {
        detailBottomBar.bottombarDelegate = self
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didTapCallButton(_ sender: UIButton) {
        if let url = URL(string: "tel://\(9847510019)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func didTapWebsiteButton(_ sender: UIButton) {
        let websiteUrlString = "http://www.techotopia.com/"
        if let websiteUrl = NSURL(string: websiteUrlString) {
            // show alert to choose app
            if UIApplication.shared.canOpenURL(websiteUrl as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(websiteUrl as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(websiteUrl as URL)
                }
            }
        }
    }
    
    @IBAction func didTapLocation(_ sender: UIButton) {
        //Working in Swift new versions.
        let latitude = 10.0158685
        let longitude =  76.3418586
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
            } else {
                 UIApplication.shared.openURL(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!)
            }
        } else {
            print("Can't use comgooglemaps://");
           
            if (UIApplication.shared.canOpenURL(URL(string:"https://maps.google.com")! ))
            {
                UIApplication.shared.openURL(URL(string:
                    "https://maps.google.com/?q=@\(latitude),\(longitude)")!)
            }
        }

    
    }
    @IBAction func didTapGmailButton(_ sender: UIButton) {
        let email = "vidyar851@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if (UIApplication.shared.canOpenURL(url))
            {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            else{
                //let urlString = URL(string: "inbox-gmail://")
               // UIApplication.shared.openURL(urlString!)
              
                
            }
        }//
    }

    @IBAction func didTapFacebookButton(_ sender: UIButton) {
      
         let facebookUrl = URL(string: "fb://profile/vidyarajan.rajan.5")
       if( UIApplication.shared.canOpenURL(facebookUrl!))
       {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(facebookUrl!, options: [:], completionHandler: nil)
            } else {
            
                UIApplication.shared.openURL(facebookUrl!)
            
        }
        }
       else{
        let facebookUrlString = URL(string: "http://www.facebook.com/vidyarajan.rajan.5")
        UIApplication.shared.openURL(facebookUrlString!)
        }
    }
    func favouriteButtonPressed() {
        
    }
    func qFindMakerPressed() {
        
    }
    func historyButtonPressed() {
        
    }

}