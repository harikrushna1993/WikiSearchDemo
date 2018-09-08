//
//  WikiDetailVC.swift
//  WikipediaDemo
//
//  Created by Hari Krushna Sahu on 08/09/18.
//  Copyright © 2018 Hari. All rights reserved.
//

import UIKit
import WebKit

class WikiDetailVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var urlString: String?
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebview()
        // Do any additional setup after loading the view.
    }

    func loadWebview() {
        if urlString != nil,
            let url = URL.init(string: urlString!) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
        if titleString != nil {
            self.navigationItem.title = titleString
        } else {
            self.navigationItem.title = "WikiDemo"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WikiDetailVC: WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        let alertController = UIAlertController(title: error.localizedDescription, message: "Error", preferredStyle: .alert)
        let leftButtonAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(leftButtonAction)
        present(alertController, animated: true, completion: nil)
        print("Failed to Load")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Loading start")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation) {
        print("didReceiveServerRedirectForProvisionalNavigation: \(navigation)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation, withError error: Error) {
        print("didFailProvisionalNavigation: \(navigation), error: \(error)")
    }
    
    func webView(_ webView: WKWebView, didFinishLoading navigation: WKNavigation) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("didFinishLoadingNavigation: \(navigation)")
    }
    
    func webViewWebProcessDidCrash(_ webView: WKWebView) {
        print("WebContent process crashed; reloading")
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let trgFrm = navigationAction.targetFrame {
            if !trgFrm.isMainFrame {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                webView.load(navigationAction.request)
            }
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (_: WKNavigationResponsePolicy) -> Void) {
        print("decidePolicyForNavigationResponse")
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (_: WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
