//
//  WebViewController.swift
//  FindAR
//
//  Created by Dev Patel on 3/13/22.
//

import UIKit
import WebKit

/// The controller for handling webviews.
class WebViewController: UIViewController {

    // MARK: - Properties
    internal lazy var button_Close: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.close, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -30, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        return button
    }()

    public var urlString: String! {
        didSet {
            if let url = URL(string: urlString) {
                let urlRequest = URLRequest(url:url)
                self.webView.load(urlRequest)
            }
        }
    }

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()

    // MARK: - Functions
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButton = UIBarButtonItem(customView: self.button_Close)
        self.button_Close.frame = CGRect(x: 0, y: 0, width: 55.0, height: 44.0)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        if #available(iOS 11.0, *) {
            negativeSpacer.width = -30
        }
        self.navigationItem.leftBarButtonItems = [negativeSpacer, barButton]

        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc func back(_ sender: Any) {
        self.dismiss()
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Show here a HUD or any loader
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Dismiss your HUD
    }
}
