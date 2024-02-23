//
//  SaveAndLoadStractures.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-16.
//

import Foundation

func save<T: Codable>(data: T, to fileName: String) {
    let encoder = JSONEncoder()
    do {
        let fileURL = try FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
            .appendingPathComponent(fileName)
        
        let data = try encoder.encode(data)
        try data.write(to: fileURL)
        print("Saved successfully to \(fileURL)")
    } catch {
        print(error.localizedDescription)
    }
}

func load<T: Codable>(from fileName: String, as type: T.Type) -> T? {
    let decoder = JSONDecoder()
    do {
        let fileURL = try FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false)
            .appendingPathComponent(fileName)
        
        let data = try Data(contentsOf: fileURL)
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    } catch {
        print(error.localizedDescription)
        return nil
    }
}
