//
//  ContentView.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 6/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var proteins: [Protein] = [Protein]()
    @State private var days: [Day] = [Day]()
    
//    @State private var currentDay: Date = Date.now
    
//    @State private var speed = 25.0
//    @State private var isEditing = false

    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

    func save(){
        DispatchQueue.main.async {
            do {
                days.last!.save(proteins: proteins)
                let data = try JSONEncoder().encode(days)
                
                let url = getDocumentDirectory().appendingPathComponent("days")
                
                try data.write(to: url)
                
            }catch {
                print("Saving Failed")
            }
        }
    }

    func load() {
        do {
            let url = getDocumentDirectory().appendingPathComponent("days")
            let data = try Data(contentsOf: url)
            days = try JSONDecoder().decode([Day].self, from: data)
            
            proteins = days.last!.proteins
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
            proteinCount = proteinCount + protein.amount
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
                    NavigationLink(destination: ProteinCalendarView(contentView: self, days: days)){
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
                                    
                    
                }.navigationTitle("Protein Counter")
                .onAppear(perform: {
                    load()
                    if days.isEmpty {
                        days.append(Day(date: Date.now, totalAmount: 0, proteins: proteins, id: UUID()))
                        
                    } else {
                        let now = Date.now
                        let lastDay = days.last!.date
                        let same = Calendar.current.isDate(lastDay, inSameDayAs: now)
                            if same == false {
                                days.append(Day())
                                proteins.removeAll()
                                save()
                            }
                    }
            })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
