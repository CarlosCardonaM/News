//
//  DetailViewController.swift
//  News
//
//  Created by Carlos Cardona on 22/05/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check that there's an url
        if articleUrl != nil {
            
            // Create the url object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                return print("Couldn't create the url object")
            }
            
            // Create the request URLRequest
            let request = URLRequest(url: url!)
            
            // Start spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
            // Load it into the web view
            webView.load(request)
            
        }
    }

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Stop the spinning and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}
