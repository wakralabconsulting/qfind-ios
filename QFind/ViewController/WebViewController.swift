//
//  WebViewController.swift
//  QFind
//
//  Created by Exalture on 14/02/18.
//  Copyright © 2018 QFind. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webViewLoader: LoadingView!
    @IBOutlet weak var titleLabel: UILabel!
    var webViewUrl: URL? = nil
    var titleString: String? = nil
    var titleFontSize =  CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        if ((titleString != nil) && (titleString != "")) {
            self.titleLabel.text = titleString
        }
        let requestObj = URLRequest(url: webViewUrl!)
        self.webView.loadRequest(requestObj)
        webView.delegate = self
        webViewLoader.isHidden = false
        webViewLoader.showLoading()
        webView.backgroundColor = UIColor.white
        webView.scrollView.bounces = false
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            titleFontSize = 35
            
        }
        else {
            titleFontSize = 25
        }
        if ((LocalizationLanguage.currentAppleLanguage()) == "en") {
            titleLabel.font = UIFont(name: "Lato-Bold", size: titleFontSize)
        }
        else {
            titleLabel.font = UIFont(name: "GESSUniqueBold-Bold", size: titleFontSize)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func didTapClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webViewLoader.stopLoading()
        webViewLoader.isHidden = true
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webViewLoader.isHidden = false
        webViewLoader.stopLoading()
        webViewLoader.showNoDataView()
    }
}
