//
//  ProteinDetailView.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 6/30/22.
//

import SwiftUI

struct ProteinDetailView: View {
    let protein: Protein
    
    var body: some View {
        VStack(alignment: .leading){
//            Text(protein.name).font(.title)
            HStack {
                VStack {
                    Text("\(protein.amount)").font(.largeTitle)
                    Text("grams")
                }
                
            }
            
        }.navigationTitle(protein.name)
    }
}

struct ProteinDetailView_Previews: PreviewProvider {
    static var sampleData: Protein = Protein(name: "Tofu", amount:8, id: UUID())
    static var previews: some View {
        ProteinDetailView(protein: sampleData)
    }
}
