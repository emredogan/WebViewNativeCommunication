//
//  SampleWebView+NavigationDelegate.swift
//  WebViewSwiftUI
//
//  Created by Emre Dogan on 22/01/2023.
//

import WebKit

extension SampleWebView: WKNavigationDelegate {
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		debugPrint("Webview didStartProvisionalNavigation")
		// Here you could start a loading indicator.
	}
	
	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		debugPrint("Webview didFail \(error)")
		// Here you could show a custom error view
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
		if let response = navigationResponse.response as? HTTPURLResponse {
			let contains = (200...399).contains(response.statusCode)
			if !contains {
				// If it is not one of the successful status codes do not allow webview to navigate any further.
				decisionHandler(.cancel)
				return
			}
		}
		decisionHandler(.allow)
	}
	
	func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		// Here you could show a custom error view
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		// Once your web view has loaded some content, you can execute any JavaScript you like inside that rendered page by using the evaluateJavaScript() method
		
		// EXAMPLE 1
		webView.evaluateJavaScript("document.getElementById('username').innerText") { (result, error) in
			if let result {
				print(result)
			}
		}
		
		// EXAMPLE 2
		// Functions is injected as properties on the `window.nativeLayer` object:
		// `postMessage(payload)` which is used to all web-to-native callbacks
		//
		// Lastly, a custom event is dispatched to signal the web page that the injected functions are ready to be used.
		let jsMessageHandler =
		"""
			window.nativeLayer = {
				postMessage: function(payload) {
					window.webkit.messageHandlers.native.postMessage(payload);
				}
			};

			document.dispatchEvent(new CustomEvent('nativeReady'));
		"""

		webView.evaluateJavaScript(jsMessageHandler) { _, _ in }
	}
}
