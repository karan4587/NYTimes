//
//  NYTimesNewsDetailViewController.swift
//  NYTimes
//
//  Created by Karan Thakkar on 22/10/18.
//  Copyright © 2018 TLIKnowledge. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
import WebKit

class NYTimesNewsDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var  webView : WKWebView!
    var webURL : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKActivityIndicator.show("Loading...", userInteractionStatus: true)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        if webURL != nil {
            let url = URL(string: webURL)!
            webView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            SKActivityIndicator.dismiss()
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            SKActivityIndicator.dismiss()
        }
    }
}
