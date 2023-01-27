//
//  JsonLoader.swift
//  Resilience
//
//  Created by Damien WALEROWICZ on 25/01/2023.
//

import Foundation

class JsonLoader {
    static func loadJson(named: String) -> [Question]? {
        if let filepath = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let questions = try decoder.decode([Question].self, from: data)
                return questions
                
                
            }catch{
                print("error loading json file")
            }
        }else{
            return nil
        }
        return nil
    }
}
