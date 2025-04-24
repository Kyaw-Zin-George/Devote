//
//  ContentView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/21/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - Property
    @State var task: String = ""
    private var isButtonDisabled: Bool { task.isEmpty }
    //Fetching Data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - function
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
        }
    }

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
    
    //MARK: Body
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    VStack(spacing: 6) {
                        TextField("New Task",text: $task)
                            .padding()
                            .background(
                                Color(UIColor.systemGray6)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Button(action: {
                            addItem()
                        } , label: {
                            Spacer()
                            Text("SAVE")
                            Spacer()
                        })
                        .disabled(isButtonDisabled)
                        .padding()
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background( isButtonDisabled ? Color.gray :
                            Color(UIColor.systemRed)
                               
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                    .padding()
                    List {
                        ForEach(items) { item in
                            
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }//List
                }//VStack
                .navigationTitle("Daily Task")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    
                }//ToolBar
                
                Text("Select an item")
            }
        }
    }
    
    
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
