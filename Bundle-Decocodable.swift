//
//  Bundle-Decocodable.swift
//  MyProjectsApp
//
//  Created by Richard Price on 12/04/2021.
//

import Foundation
//add awards json file and create an extension of bundle
//this is an extremely useful extension allowing you to download JSON from files that live
//in your project (not network json it will fail across the board) but local this is perfect
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}


//Notes
/*
T can’t be anything because Swift can’t decode any kind of data. Instead, we want to use Swift’s Codable system, and that means we are happy for T to be any kind of data at all as long as it’s something that conforms to Decodable. (In case you didn’t know, Codable isn’t actually a protocol by itself, and is instead just a typealias for Encodable and Decodable.
 the important part: we need to decode that data into whatever type was requested. We’ve already passed in some kind of type, so we can use T.self to refer to that type inside our code.
 
 */
