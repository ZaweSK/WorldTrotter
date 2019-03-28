//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Peter on 28/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate
{

    //MARK: - VC life cycle
    
    override func loadView() {
        super.loadView()
        
        spinner.startAnimating()
        webView.navigationDelegate = self
        
        let url = URL(string: "https://www.bignerdranch.com")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
        
        webView.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
    }
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    //MARK: - WKNavigationDelegate methods
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
    
    


}
