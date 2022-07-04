//
//  PastProteinListView.swift
//  ProteinCounter WatchKit Extension
//
//  Created by Jonathan Miller on 6/30/22.
//

import SwiftUI

struct PastProteinListView: View {
    
    let contentView: ContentView
    let day: Day
    let dateFormatter: DateFormatter = DateFormatter()
    
    init(contentView: ContentView, day: Day)
    {
        self.contentView = contentView
        self.day = day
        dateFormatter.dateFormat = "E, MMMM d"
    }

    var body: some View {
        if day.proteins.count > 0 {
            List
            {
                ForEach(0..<day.proteins.count, id: \.self)
                {
                    i in NavigationLink(destination: ProteinDetailView(protein: day.proteins[i])) {
                        HStack {
                            Capsule()
                                .frame(width: 4)
                                .foregroundColor(.accentColor)
                            Text(day.proteins[i].name)
                                .lineLimit(1)
                                .padding(.leading, 5)
                        }
                    }
                }
                // - Work In Progress -
                //.onDelete(perform: contentView.delete)
            }.navigationTitle(dateFormatter.string(from: day.date))
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

struct PastProteinListView_Previews: PreviewProvider {
    static var contentView: ContentView = ContentView()
    static var day: Day = Day()
    
    static var previews: some View {
        PastProteinListView(contentView: contentView, day: day)
    }
}

