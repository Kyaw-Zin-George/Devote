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
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
//    //Fetching Data
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    
    
    //MARK: Body
    var body: some View {
        
            NavigationStack {
                ZStack {
                   // backgroundGradient.ignoresSafeArea()
                    //MARK: - Main View
                    VStack {
                        
                        //MARK: - Header
                        HeaderView()
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
                       
                        
                        TaskListView()
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
                .toolbar(.hidden)
                .background(BackgroundImageView())
                .background(backgroundGradient.ignoresSafeArea())
                
                
                
                
            }//navigation view
            
     
    }
    
    
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
