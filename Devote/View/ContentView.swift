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
                            .padding()
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
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                    .transition(.move(edge: .bottom))
                    .animation(.easeOut(duration: 1), value: isDarkMode)
                    //MARK: - Tasks Items
                    if showNewTaskItem{
                        BlankView(
                            backgroundColor: isDarkMode ?  Color.black : Color.gray,
                            backgroundOpacity: 0.3)
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
                .background(BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0,opaque: false))
                .background(backgroundGradient.ignoresSafeArea())
                
            }//navigation view
            
     
    }
    
    
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
