//
//  ProteinListView.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 6/30/22.
//

import SwiftUI

struct ProteinListView: View {
    
    let contentView: ContentView
    let proteins: [Protein]

    var body: some View {
        if proteins.count > 0 {
            List
            {
                ForEach(0..<proteins.count, id: \.self)
                {
                    i in NavigationLink(destination: ProteinDetailView(protein: proteins[i])) {
                        HStack {
                            Capsule()
                                .frame(width: 4)
                                .foregroundColor(.accentColor)
                            Text(proteins[i].name)
                                .lineLimit(1)
                                .padding(.leading, 5)
                        }
                    }
                }.onDelete(perform: contentView.delete)
            }
        } else {
            Spacer()
            Image(systemName: "note.text")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .opacity(0.25)
                .padding(25)
            Spacer()
        }
    }
}

struct ProteinListView_Previews: PreviewProvider {
    static var contentView: ContentView = ContentView()
    static var proteins: [Protein] = [Protein]()
    
    static var previews: some View {
        ProteinListView(contentView: contentView, proteins: proteins)
    }
}
