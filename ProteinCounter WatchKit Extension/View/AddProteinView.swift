//
//  AddProteinView.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 6/30/22.
//

import SwiftUI

struct AddProteinView: View {
    
    let contentView: ContentView
    @Environment(\.presentationMode) var presentation
    @State private var name: String = ""
    @State private var amount: String = ""
    
    var body: some View {
        VStack {
            TextField("Food Name", text: $name)
            HStack {
                TextField("Protein (grams)", text: $amount)
                Button {
                    contentView.addProtein(name: name, amount: amount)
                    presentation.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "plus")
                }
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
            }
            
        
        
        }.navigationTitle("Add Protein").foregroundColor(.blue)
        
    }
}

struct AddProteinView_Previews: PreviewProvider {
    static var contentView: ContentView = ContentView()
    
    static var previews: some View {
        AddProteinView(contentView: contentView)
    }
}
