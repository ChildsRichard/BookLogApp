//
//  Extensions.swift
//  BookLog
//
//  Created by Richard Childs on 4/23/25.
//
import Foundation

extension Encodable {
    func asDictionary() -> [String:Any]{
        
        if let data = try? JSONEncoder().encode(self){
            do{
                let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
                return json ?? [:]
            } catch {
                return [:]
            }
        } else {
            return [:]
        }
        
    }
    
    
    
    
}
