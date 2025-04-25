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
    @State private var showNewTaskItem: Bool = false
    
    //Fetching Data
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
    
    //MARK: Body
    var body: some View {
        
            NavigationStack {
                ZStack {
                   // backgroundGradient.ignoresSafeArea()
                    //MARK: - Main View
                    VStack {
                        
                        //MARK: - Header
                        Spacer(minLength: 80)
                        //MARK: - New Task Button
                        Button(action: {
                            showNewTaskItem = true
                        }) {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                            Text("New Task")
                                .font(.system(size: 24,weight: .bold,design: .rounded))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal,20)
                        .padding(.vertical,15)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .leading, endPoint: .trailing)
                                .clipShape(Capsule())
                        )
                       
                       
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
                        .listStyle(InsetGroupedListStyle())
                        .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 12)
                        .padding()
                        .frame(maxWidth: 640)
                    }//VStack
                    //MARK: - Tasks Items
                    if showNewTaskItem{
                        BlankView()
                            .onTapGesture {
                                withAnimation(){
                                    showNewTaskItem = false
                                }
                            }
                        NewTaskItemView(isShowing:  $showNewTaskItem)
                    }
                }//ZStack
//                .onAppear(){
//                    UITableView.appearance().backgroundColor = .clear
//                }
                
                .navigationTitle("Daily Task")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    #if os(iOS)
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    #endif
                    
                }//toolbar
                .background(BackgroundImageView())
                .background(backgroundGradient.ignoresSafeArea())
                
                
                
                
            }//navigation view
            
     
    }
    
    
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
