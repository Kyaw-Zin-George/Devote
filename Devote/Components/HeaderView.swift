//
//  HeaderView.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/26/25.
//

import SwiftUI

struct HeaderView: View {
    @State private var showNewTaskItem: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some View {
        HStack(spacing: 10) {
            //Title
            Text("Devote")
                .font(.system(.largeTitle,design: .rounded))
                .fontWeight(.heavy)
                .padding()
            Spacer()
            //Edit Button
            EditButton()
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .padding(.horizontal, 10)
                .frame(minWidth: 70,minHeight: 24)
                .foregroundStyle(.white)
                .background(
                    Capsule().stroke(Color.white,lineWidth: 2)
                )
            //Appearance Button
            Button(action: {
                isDarkMode.toggle()
                playSound(sound: "sound-tap", type: "mp3")
                feedback.notificationOccurred(.success)
            }) {
                Image(systemName: isDarkMode ? "moon.circle.fill":"moon.circle")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .foregroundStyle(.white)
            }
            
        }
    }
}

#Preview {
    HeaderView()
        .background(Color.gray)
}
