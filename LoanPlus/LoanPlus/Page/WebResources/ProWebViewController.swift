//
//  ProWebViewController.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/12/4.
//

import UIKit
import SnapKit

import WebKit
import StoreKit


class ProWebViewController: BaseVC, WKNavigationDelegate, WKUIDelegate {
    
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    var url: String = ""
    var noBackRoot: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [self] in
            
            
            let urlString = self.url.replacingOccurrences(of: " ", with: "")
            var fullURLString = "\(urlString)\(urlString.contains("?") ? "&" : "?")\(getRequestHeader())"
            fullURLString = fullURLString.replacingOccurrences(of: " ", with: "")
            print("#########" + fullURLString)
            
            if let url = URL(string: fullURLString) {
                webView.load(URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60))
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func navView() {
        
        progressView = UIProgressView()
        progressView.backgroundColor = .gray
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(NavBarHeight+1);
            make.height.equalTo(1.5)
        }
    }
    
    private func loadUI() {
        navView()
        
        let wkConfig = WKWebViewConfiguration()
        wkConfig.preferences.javaScriptEnabled = true
        wkConfig.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        let wkUController = WKUserContentController()
        wkConfig.userContentController = wkUController
        addScriptMessageHandler(to: wkConfig)
        
        webView = WKWebView(frame: .zero, configuration: wkConfig)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom)
        }
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
    }
    
    private func addScriptMessageHandler(to config: WKWebViewConfiguration) {
        
        let messageNames = ["rUIpLoaskdLo", "rUIpLoaskdLo11", "juGoPlaghomP", "oUrPenltyiu", "coLosHopy", "cAtoIndxx","bDhdPcall","YypFgoapp"]
        for name in messageNames {
            config.userContentController.add(self, name: name)
        }
    }
    
    private func getRequestHeader() -> String {
        
        let params:[String:Any] = ["fAYUxpHUnjmBwGmcdSczaFrZtuZP":"ios",
                                   "uMEMEcDsjXLLlQPy": DeviceManager.getAppVersion(),
                                   "FxpSSsAwRFoegtSoUEPg":DeviceManager.getModelName(),
                                   "KFfcABnExHRByLTZpetw":DeviceManager.getIDFV(),
                                   "vjuoBzixWZVyDOTHmj":DeviceManager.getSystemVersion(),
                                   "rcznbeRnHTsKnaMMe":"superp-sp",
                                   "rBsPRLsGdjGWMXZ": UserM.sessionId,//SessionId
                                   "qXKkufSJISMUrtLHMqKcQrYmBePHz":AppTrack.idfaID,
                                   "mobilePhone":UserM.phone,//phone number
                                   "dqRTAcPsXwobSxnoX":"super_ios8",
                                   "packageId":DeviceManager.getAppBundleId(),
                                   "merchantName":"ios"
        ]
        return params.sorted { $0.key < $1.key }.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1.0 {
                UIView.animate(withDuration: 0.25, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
                }) { _ in
                    self.progressView.isHidden = true
                }
            }
        } else if keyPath == "title" {
            title = webView.title
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    
    
    override func back() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            super.back()
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}










extension ProWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage){
        print("--------- \(message.name) ----- \(message.body)")
        
        var tmp: [Any]?
        var path:String?
        if let bodyArray = message.body as? [Any] {
            tmp = bodyArray
        }
        if let bodyPath = message.body as? String {
            path = bodyPath
        }
        
        switch message.name {
        case "rUIpLoaskdLo":
            //埋点12
            do {
                let productID = tmp?.first
                let orderID = tmp?.last
                
                AppTrack.riskInfo("12", "0", productID as! String)
                
            }
            
            
        case "rUIpLoaskdLo11":
            //埋点11
            do {
                let productID = tmp?.first
                let orderID = tmp?.last
                AppTrack.riskInfo("11", "0", productID as! String)
            }
            
        case "juGoPlaghomP":
            
            
            
            if let url = URL(string: path ?? "")  {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        case "oUrPenltyiu":
            //风控埋点
            
            Applyed.jumpCheck(path: path ?? "")
        case "coLosHopy":
            //风控埋点
            
            back()
            
        case "cAtoIndxx":
            //风控埋点
            
            Page.switchTabBar(index: 0)
            
            
            
            
        case "bDhdPcall":
            if let phone = path {
                let cleanedPhone = phone.replacingOccurrences(of: " ", with: "")
                self.makeAPhoneCall(phoneNumber: cleanedPhone)
            }
            
        case "YypFgoapp":
            if #available(iOS 14.0, *) {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: windowScene)
                }
            } else if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
            
        default:
            break
        }
    }
    
    func makeAPhoneCall(phoneNumber: String) {
        let phoneURLString = "telprompt://\(phoneNumber)"
        if let url = URL(string: phoneURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
