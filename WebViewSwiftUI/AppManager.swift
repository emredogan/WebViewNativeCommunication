//
//  AppManager.swift
//  WebViewSwiftUI
//
//  Created by Emre Dogan on 22/01/2023.
//

import Combine

class AppManager {

	static let shared = AppManager()

	private init() { }

	let alertMessageSignal = PassthroughSubject<String, Never>()
}
