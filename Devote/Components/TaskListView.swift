//
//  ListView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/26/25.
//

import SwiftUI

struct TaskListView: View {
    @State var task: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - function
   
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    var body: some View {
        List {
            ForEach(items) { item in
                ListRowItemView(item: item)
            }
            .onDelete(perform: deleteItems)
        }//List
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .listStyle(InsetGroupedListStyle())
        .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 12)
        .padding()
//     .frame(maxWidth: 640)
        
    }
}

#Preview {
    TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .background(Color.blue)
}
