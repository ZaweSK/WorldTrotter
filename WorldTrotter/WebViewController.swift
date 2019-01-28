//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Peter on 28/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    override func loadView() {
        super.loadView()
        webView.navigationDelegate = self
        
        let url = URL(string: "https://www.bignerdranch.com")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
