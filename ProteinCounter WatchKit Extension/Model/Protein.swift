//
//  Note.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 6/23/22.
//

import Foundation

struct Protein: Identifiable, Encodable, Decodable {
    let name: String
    let amount: Int
    let id: UUID
}
