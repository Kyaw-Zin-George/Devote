//
//  Constants.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/23/25.
//

import Foundation
import SwiftUI

//Date Formatter

 let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK: - UI
var backgroundGradient: LinearGradient {
    LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
//MARK: - UX
let feedback = UINotificationFeedbackGenerator()
