//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/25/25.
//

import SwiftUI

struct NewTaskItemView: View {
    //properties
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    @Binding var isShowing: Bool
    
    //MARK: - Functions
    private var isButtonDisabled: Bool { task.isEmpty }
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
            isShowing = false
        }
    }

    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 6) {
                TextField("New Task",text: $task)
                    .foregroundStyle(.pink)
                    .font(.system(size: 24, weight: .bold,design: .rounded))
                    .padding()
                    .background(
                        Color(isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Button(action: {
                    addItem()
                } , label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold,design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .padding()
                .foregroundStyle(.white)
                .background( isButtonDisabled ? Color.blue :
                                Color(UIColor.systemRed)
                             
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }
            
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground    ) : Color(UIColor.white)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }//vstack
        .padding()
    }
}

#Preview {
    NewTaskItemView(isShowing: .constant(true))
        .background(Color.gray.ignoresSafeArea())
        
        
}
