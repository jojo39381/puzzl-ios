//
//  PZWebViewController.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/30/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class PZWebViewController: UIViewController, WKScriptMessageHandler {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebbView()
        ResponseService.shared.onboardWorker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stylizeNavigationFont(buttonTitle: "", color: UIColor.black.withAlphaComponent(0.54))
    }
    
    private func configureWebbView() {
        if let signURL = NSURLComponents(string: PassingData.shared.helloSignModel?.signURL ?? "") {
            
            if  let signatureId = signURL.queryItems?.filter({$0.name == "signature_id"}).first,
                let token = signURL.queryItems?.filter({$0.name == "token"}).first,
                let url = NSURLComponents(string: "https://app.joinpuzzl.com/mobile/hellosign") {
                
                url.queryItems = [signatureId, token]
                
                print("URL: ", url.url?.absoluteString ?? "")
                
                let contentController = WKUserContentController()
                contentController.add(
                    self,
                    name: "callbackHandler"
                )
                contentController.add(
                    self,
                    name: "parseHelloSign"
                )
                contentController.add(
                    self,
                    name: "iOS.parseHelloSign"
                )


                let config = WKWebViewConfiguration()
                config.userContentController = contentController
                
                let webView = WKWebView(frame: self.view.frame, configuration: config)
                webView.navigationDelegate = self
                view = webView
                
                webView.load(NSURLRequest(url: url.url ?? URL(string: "https://app.joinpuzzl.com/mobile/hellosign")!) as URLRequest)
                
            }
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let messageBody = message.body as? [String: Any] {
            if let status = messageBody["status"] as? String {
                if status == "finished" {
                    navigationController?.pushViewController(.finish, animated: true)
                }
            }
        }
    }
}

extension PZWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
