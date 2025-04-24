//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Kyaw Thant Zin(George) on 4/24/25.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resolveInstanceMethod(_:)), to: nil, from: nil, for: nil)
        
    }
}
#endif
