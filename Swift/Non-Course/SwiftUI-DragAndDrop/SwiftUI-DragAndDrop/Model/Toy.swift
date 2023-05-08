//
//  Toy.swift
//  SwiftUI-DragAndDrop
//
//  Created by Muhammad Abdul Fattah on 14/04/23.
//

import Foundation
import SwiftUI

struct Toy {
    let id: Int
    let color: Color
}

extension Toy {
    static let all = [
        Toy(id: 1, color: .red),
        Toy(id: 2, color: .blue),
        Toy(id: 3, color: .green),
        Toy(id: 4, color: .black),
        Toy(id: 5, color: .orange),
        Toy(id: 6, color: .purple)
    ]
}
