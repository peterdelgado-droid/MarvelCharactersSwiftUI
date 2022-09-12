//
//  BaseNetwork.swift
//  MarvelCharactersSwiftUI
//
//  Created by Peter Delgado on 8/9/22.
//

import Foundation


import Foundation
import CryptoKit

let server = "https://gateway.marvel.com"

let privateKey = "8c8ad9897fdc3bb8ae1268acd9a89741ba0b720a"
let publicKey = "1e113f8b3d71dca2aa057267609e35fb"
let ts = 1
let orderBy = "-modified"

//let md5InputData = "\(ts)\(privateKey)\(publicKey)".data(using: .utf8)!
//let digest = Insecure.MD5.hash(data: md5InputData)
//let hashString = digest.map { String(format: "%02x", $0) }.joined()

let hashString = "9565dbf8edebc6148572a8c4aee08076"

struct HTTPMethods {
	static let post = "POST"
	static let get = "GET"
	static let content = "application/json"
}

enum endpoints: String {
	case characters = "/v1/public/characters"
	//TODO: ¿Como meter un parametro?
	case characterSeries = "/v1/public/characters/{characterId}/series"
}

struct BaseNetwork {

	func getSessionCharacters() -> URLRequest? {
		let urlStr = "\(server)\(endpoints.characters.rawValue)?apikey=\(publicKey)&ts=\(ts)&hash=\(hashString)&orderBy=\(orderBy)"

		guard let urlServer = URL(string: urlStr) else {
			return nil
		}

		var request = URLRequest(url: urlServer)
		request.httpMethod = HTTPMethods.get
		request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")

		return request
	}

	func getSessionCharacterSeries(characterId: Int) -> URLRequest? {
		let urlStr = "\(server)/v1/public/characters/\(characterId)/series?apikey=\(publicKey)&ts=\(ts)&hash=\(hashString)&orderBy=\(orderBy)"

		guard let urlServer = URL(string: urlStr) else {
			return nil
		}

		var request = URLRequest(url: urlServer)
		request.httpMethod = HTTPMethods.get
		request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")

		return request
	}
}

