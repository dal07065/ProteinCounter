//
//  Day.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 7/2/22.
//

import Foundation

class Day: Identifiable, Encodable, Decodable {
    let date: Date
    var totalAmount: Int
    var proteins: [Protein] = [Protein]()
    let id: UUID
    
    public func save(proteins: [Protein])
    {
        self.proteins = proteins
        updateTotalAmount()
    }
    
    public func updateTotalAmount()
    {
        totalAmount = 0
        for protein in proteins {
            totalAmount = totalAmount + protein.amount
        }
    }
    
    init(date: Date = Date.now, totalAmount: Int = 0, proteins: [Protein] = [Protein](), id: UUID = UUID()){
        self.date = date
        self.totalAmount = totalAmount
        self.proteins = proteins
        self.id = id
    }
    
}
