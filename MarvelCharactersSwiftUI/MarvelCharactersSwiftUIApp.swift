//
//  MarvelCharactersSwiftUIApp.swift
//  MarvelCharactersSwiftUI
//
//  Created by Peter Delgado on 8/9/22.
//

import SwiftUI

@main
struct MarvelCharactersSwiftUIApp: App {

	@StateObject var characstersViewModel = CharactersViewModel()

	var body: some Scene {
        WindowGroup {
			RootView()
				.environmentObject(characstersViewModel)
           // ContentView()
        }
    }
}
