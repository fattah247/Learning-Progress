//
//  DraggableToy.swift
//  SwiftUI-DragAndDrop
//
//  Created by Muhammad Abdul Fattah on 14/04/23.
//

import SwiftUI

struct DraggableToy: View {
    var body: some View {
        Circle()
            .fill(.red)
            .frame(width: 100, height: 100)
    }
}

struct DraggableToy_Previews: PreviewProvider {
    static var previews: some View {
        DraggableToy()
    }
}
