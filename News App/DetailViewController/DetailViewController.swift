//
//  DetailViewController.swift
//  News App
//
//  Created by Юрий Могорита on 26.10.2020.
//  Copyright © 2020 Yuri Mogorita. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    private var estimatedProgressObserver: NSKeyValueObservation?
    var article: Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0
        setupEstimatedProgressObserver()
        loadPage()
    }
    
    //MARK: - ProgressView progress
    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func loadPage() {
        if let url = article?.url, !url.isEmpty && NetworkManager.shared.doesTheInternetWork  {
            guard let url = URL(string: url) else { return }
            webView.load(URLRequest(url: url))
        } else {
            let alert = UIAlertController(title: "Error", message: "Connection is lost", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        }
    }
}
