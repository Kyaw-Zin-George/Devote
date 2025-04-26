//
//  ListView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/26/25.
//

import SwiftUI

struct TaskListView: View {
    var body: some View {
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
    }
}

#Preview {
    TaskListView()
}
