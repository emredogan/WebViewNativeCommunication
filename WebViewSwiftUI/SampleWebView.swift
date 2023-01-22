//
//  SampleWebView.swift
//  WebViewSwiftUI
//
//  Created by Emre Dogan on 20/01/2023.
//

import WebKit

class SampleWebView: WKWebView {
	
	// Message handler identifier should match the identifier in the HTML.
	// In our first html see that: Whenever submitForm function is called the following is called: window.webkit.messageHandlers.observer.postMessage(message);
	// As you can see here the message handler identifier is observer.
	
	// FOR FIRST FORM
	//let scriptMessageHandlerIdentifier = "observer"
	
	// FOR SECOND FORM
	let scriptMessageHandlerIdentifier = "native" // If send through nativeLayer we could give identifier as native
	let contentController = WKUserContentController()
	init() {
		// The rest is standard implementation
		let configuration = WKWebViewConfiguration()
		configuration.processPool = WKProcessPool()
		configuration.userContentController = contentController

		super.init(frame: .zero, configuration: configuration)
		navigationDelegate = self
		contentController.add(self, name: scriptMessageHandlerIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
