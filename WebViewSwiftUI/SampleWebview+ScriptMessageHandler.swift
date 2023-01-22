//
//  SampleWebview+ScriptMessageHandler.swift
//  WebViewSwiftUI
//
//  Created by Emre Dogan on 20/01/2023.
//

import WebKit

enum ScriptMessage: String {
	case test
	case showOverlay
	case hideOverlay
}

// Based on the response (post message) we create this model
// FIRST FORM HTML
struct JSResponseModelFormHTML: Decodable {
	var name: String
	var email: String
}

// SECOND FORM HTML
struct JSResponseModelSecondFormHTML: Decodable {
	var type: String
	var color: String?
}

/// A JavaScript bridge handler, for bridging native and web behavior.
extension SampleWebView: WKScriptMessageHandler {
	
	// FOR FIRST HTML
	// If you have a fixed amount of possible response create those and handle them in switch statement
	enum PeopleNames: String {
		case Emre
		case Tanguy
		case Stathis
	}
	
	enum PeopleEmails: String {
		case gmail
		case hotmail
		case yahoo
	}
	
	// This is where we receive the data when user takes an action on the WebView (If you did userContentController setup correctly)
	func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
		// Reading message and turning into an object- JSResponseModel
		
		print(message.body)
		
		//handleFormHTML(message: message)
		handleSecondFormHTML(message: message)
	}
	
	func handleFormHTML(message: WKScriptMessage) {
		do {
			// Get json data from the message body
			let jsonData = try JSONSerialization.data(withJSONObject: message.body)
			// Decode it by using the response model that we created.
			let response = try JSONDecoder().decode(JSResponseModelFormHTML.self, from: jsonData)

			// From the response model grab the name
			guard let nameMessage = PeopleNames(rawValue: response.name) else {
				return debugPrint("Unsupported JS command type: \(message.body)")
			}
			
			// From the response model grab the email
			guard let emailMessage = PeopleEmails(rawValue: response.email) else {
				return debugPrint("Unsupported JS command type: \(message.body)")
			}

			// Based on the value take the action that you want to take in the app.
			switch nameMessage {
				case .Emre:
					print("That is a Turkish guy")
				case .Tanguy:
					print("That is a French guy")
				case .Stathis:
					print("That is a Greek guy")
			}
			
			switch emailMessage {
				
				case .gmail:
					print("This is a modern email")
				case .hotmail:
					print("Old popular email")
				case .yahoo:
					print("Old popular email and search engine")
			}

			debugPrint("WebView didReceive: \(message.body)")
		} catch {
			debugPrint("WebView didReceive failure: \(error.localizedDescription)")
		}
	}
	
	func handleSecondFormHTML(message: WKScriptMessage) {
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: message.body)
			let response = try JSONDecoder().decode(JSResponseModelSecondFormHTML.self, from: jsonData)

			guard let scriptMessage = ScriptMessage(rawValue: response.type) else {
				return debugPrint("Unsupported JS command type: \(message.body)")
			}

			switch scriptMessage {
				case .test:
					AppManager.shared.alertMessageSignal.send("Hello JS Bridge!")
				case .showOverlay:
					break
				case .hideOverlay:
					break
			}
			debugPrint("WebView didReceive: \(message.body)")
		} catch {
			debugPrint("WebView didReceive failure: \(error.localizedDescription)")
		}
	}
}

// IMPORTANT NOTE

// What happens if we don’t have access to the web-page to add the JavaScript snippet and we still want to receive the message? Fortunately, we can inject some JavaScript code to a web-page that we load on a WKWebView
