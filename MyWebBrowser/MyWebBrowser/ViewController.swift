//
//  ViewController.swift
//  MyWebBrowser
//
//  Created by 이민욱 on 2020/02/10.
//  Copyright © 2020 FishinGom. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    // MARK: Properties
    // MARK: IBoutlets
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.webView.navigationDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let firstPageURL: URL?
        
        if let lastURL = UserDefaults.standard.url(forKey: lastPageURLDefaultKey) {
            firstPageURL = lastURL
        } else {
            firstPageURL = URL(string: "https://google.com")
        }
        
        guard let pageUrl: URL = firstPageURL else {
            return
        }
        
        let urlRequest: URLRequest = URLRequest(url: pageUrl)
        self.webView.load(urlRequest)
    }
    
    // MARK: IBActions
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        self.webView.goForward()
    }
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    // MARK: Custom Methods
    func showNetworkingIndicators() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideNetworkingIndicators() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension ViewController: WKNavigationDelegate {
    // MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish navigation")
        
        if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.lastPageURL = webView.url
        }
        
        webView.evaluateJavaScript("document.title") { (value: Any?, error: Error?) in
            if let error: Error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let title: String = value as? String else {
                return
            }
            
            self.navigationController?.title = title
        }
        self.hideNetworkingIndicators()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("did fail navigation")
        print("\(error.localizedDescription)")
        
        self.hideNetworkingIndicators()
        let message: String = "오류발생!\n" + error.localizedDescription
        
        let alert: UIAlertController
        alert = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAuction: UIAlertAction
        okAuction = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(okAuction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
