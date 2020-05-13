//
//  WebView.swift
//  HackerNews
//
//  Created by George Sun on 4/26/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

//MARK: -
struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = urlString {
            if let url = URL(string: url) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
