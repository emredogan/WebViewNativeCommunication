//
//  SampleWebView.swift
//  WebViewSwiftUI
//
//  Created by Emre Dogan on 20/01/2023.
//

import WebKit
import SwiftUI

struct SwiftUIWebView: UIViewRepresentable {
	// This is how you wrap a UIKit view and make the web view available to SwiftUI.
	// The method is responsible for creating and initializing the view object
	func makeUIView(context: Context) -> SampleWebView {
		return SampleWebView()
	}
	
	// This is where we update the view and load the page we want
	func updateUIView(_ webView: SampleWebView, context: Context) {
		loadPage(webView)
	}
	
	// Use the custom html file that we have in the project
	private func loadPage(_ wkWebView: WKWebView) {
		if let url = Bundle.main.url(
			// Switch between loading different htmls here
			//forResource: "form", withExtension: "html"
			forResource: "secondForm", withExtension: "html"
		) {
			wkWebView.load(URLRequest(url: url))
		}
	}
}
