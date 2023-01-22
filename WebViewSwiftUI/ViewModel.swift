//
//  ViewModel.swift
//  WebViewSwiftUI
//
//  Created by Emre Dogan on 22/01/2023.
//

import Combine

class ViewModel: ObservableObject {
	var alertSignalCancellable: AnyCancellable?
	@Published var showAlert = false
	
	init() {
		alertSignalCancellable = AppManager.shared.alertMessageSignal.sink(receiveCompletion: { result in
			switch result {
				case .finished: break
				case .failure: break
			}
		}, receiveValue: { [weak self] message in
			self?.showAlert = true
		})
	}
	
}
