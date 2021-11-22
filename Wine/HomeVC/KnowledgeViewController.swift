//
//  KnowledgeViewController.swift
//  Wine
//
//  Created by Apple on 19/07/21.
//

import UIKit
import SafariServices
import WebKit
class KnowledgeViewController: UIViewController,UIWebViewDelegate, WKNavigationDelegate {

    
    var webView = WKWebView()
    @IBOutlet weak var viewForweb: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        webViewcalling()
        APPDELEGATE.isBack = true
    }
    
    func webViewcalling(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        guard let url = URL(string: "http://54.201.206.5/wineblogs") else { return }
          webView.frame = viewForweb.bounds
          webView.navigationDelegate = self
          webView.load(URLRequest(url: url))
          webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        viewForweb.addSubview(webView)
        // Do any additional setup after loading the view.
        let reachability = Reachability()!
        if !reachability.isReachable
        {
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)

            let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("No internet", comment: ""), message: "", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { action -> Void in
                //Do your task
            }
            actionSheetController.addAction(cancelAction)
            self.present(actionSheetController, animated: true, completion: nil)
            
        } else {
        }

    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("http://54.201.206.5/wineblogs"),
                UIApplication.shared.canOpenURL(url) {
                //UIApplication.shared.open(url)
               // print(url)
                print("Redirected to browser. No need to open it locally")
                //decisionHandler(.cancel)
                decisionHandler(.allow)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
    
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let url = webView.url
        
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        print(url as Any) // this will print url address as option field
        if url?.absoluteString.range(of: ".url") != nil {
             ///pdfBackButton.isHidden = false
             print("PDF contain")
        }
        else {
           //  pdfBackButton.isHidden = true
             print("No PDF Contain")
        }
    }

}
