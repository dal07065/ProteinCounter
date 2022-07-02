//
//  ContentView.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 6/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var proteins: [Protein] = [Protein]()
    
//    @State private var speed = 25.0
//    @State private var isEditing = false

    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

    func save(){
        DispatchQueue.main.async {
            do {
                
                let data = try JSONEncoder().encode(proteins)
                
                let url = getDocumentDirectory().appendingPathComponent("proteins")
                
                try data.write(to: url)
                
            }catch {
                print("Saving Failed")
            }
        }
    }

    func load() {
        do {
            let url = getDocumentDirectory().appendingPathComponent("proteins")
            let data = try Data(contentsOf: url)
            proteins = try JSONDecoder().decode([Protein].self, from: data)
            
        }catch {
            
        }
    }

    public func delete(offsets: IndexSet)
    {
        withAnimation{
            proteins.remove(atOffsets: offsets)
            save()
        }
    }
    
    public func addProtein(name: String, amount: String)
    {
        proteins.append(Protein(name: name, amount: Int(amount) ?? 0, id: UUID()))
        print(proteins)
        save()
    }
    
    func getProteinCount() -> String
    {
        var proteinCount: Int = 0
        for protein in proteins {
            proteinCount = +protein.amount
        }
        return String(proteinCount)
    }

    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                
                Text(getProteinCount()).font(.system(size: 35)).foregroundColor(.white)
                Text(" grams today").foregroundColor(.white)
                Spacer(minLength: 15)
                HStack{
                    NavigationLink(destination: AddProteinView(contentView: self)){
                        Image(systemName: "plus").foregroundColor(.accentColor)
                    }
                    
                    NavigationLink(destination: ProteinListView(contentView: self, proteins: proteins)){
                        Image(systemName: "list.bullet").foregroundColor(.accentColor)
                        
                    }
                    NavigationLink(destination: PastProteinListView(contentView: self, proteins: proteins)){
                        Image(systemName: "calendar").foregroundColor(.accentColor)
                        
                    }
                }
                    
                    
    //                Text("\(proteins.count)")
                    
        //                Slider(
        //                            value: $speed,
        //                            in: 0...50,
        //                            step: 1,
        //                            onEditingChanged: { editing in
        //                                isEditing = editing
        //                            }
        //                        )
        //                        Text("\(speed, specifier: "%.0f")")
                                    
                    
                }
            .navigationTitle("Protein Counter")
                .onAppear(perform: {
                    load()
            })
        }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
