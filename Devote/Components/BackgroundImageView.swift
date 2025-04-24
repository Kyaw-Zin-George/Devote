//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/24/25.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
            
    }
}

#Preview {
    BackgroundImageView()
}
