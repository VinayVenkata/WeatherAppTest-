//
//  DetailViewController.swift
//  WeatherAppTest
//
//  Created by Vinay on 8/2/18.
//  Copyright © 2018 iOSApp. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    var urlPath: String?
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var awebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlPathStr = urlPath {
            showActivity(true)
            awebView.uiDelegate = self
            awebView.navigationDelegate = self
            let url = URL(string: urlPathStr)
            let requestObj = URLRequest(url: url! as URL);
            awebView.load(requestObj as URLRequest)
        }
      
        // Do any additional setup after loading the view.
        
    }
    @IBAction func goBack(_ sender: Any) {
        if awebView.canGoBack {
            awebView.goBack()
        }
    }
    
    @IBAction func goForward(_ sender: Any) {
        if awebView.canGoForward {
            awebView.goForward()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivity(false)
        print("finish loading")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivity(false)
        print("Fail loading")
    }

    func showActivity(_ isShowing: Bool) {
        loadingView.isHidden = !isShowing
        isShowing ? activityIndicatorView.startAnimating() :  activityIndicatorView.stopAnimating()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
