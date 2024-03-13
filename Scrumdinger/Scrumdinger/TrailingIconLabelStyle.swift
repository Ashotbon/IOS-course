//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Ashot Harutyunyan on 2024-03-05.
//

import SwiftUI


struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}


extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
