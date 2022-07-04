import SwiftUI

struct ProteinCalendarView: View {
    
    let contentView: ContentView
    let days: [Day]
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    init(contentView: ContentView, days: [Day])
    {
        self.contentView = contentView
        self.days = days
        dateFormatter.dateFormat = "E, MMMM d"
    }

    var body: some View {
        List{
            ForEach(0..<days.count, id: \.self)
            {
                i in NavigationLink(destination: PastProteinListView(contentView: contentView, day: days[i])) {
                    HStack {
                            Capsule()
                                .frame(width: 4)
                                .foregroundColor(.accentColor)
                        Text(" \(days[i].totalAmount)g").bold()
                        Text("\(dateFormatter.string(from: days[i].date))")
                                .lineLimit(1)
                                .padding(.leading, 5)
                    }
                }
            }
        }.navigationTitle("Calendar")
    }
}

struct ProteinCalendarView_Previews: PreviewProvider {
    static var contentView: ContentView = ContentView()
    static var days: [Day] = [Day]()
    
    static var previews: some View {
        ProteinCalendarView(contentView: contentView, days: days)
    }
}
