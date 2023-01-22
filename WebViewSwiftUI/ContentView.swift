//
//  ContentView.swift
//  WebViewSwiftUI
//
//  Created by Emre Dogan on 20/01/2023.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject private var viewModel: ViewModel = ViewModel()
    var body: some View {
        VStack {
            SwiftUIWebView()
        }
        .padding()
		.alert("Received the message", isPresented: $viewModel.showAlert) {
			EmptyView()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
