//
//  ListRowItemView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/26/25.
//

import SwiftUI

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(size: 17, weight: .medium,design: .rounded))
                .foregroundStyle(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default)
        }
        .toggleStyle(CheckBoxStyleView())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}


