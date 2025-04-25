//
//  BlankView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/25/25.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0,maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .opacity(0.5)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    BlankView()
}
