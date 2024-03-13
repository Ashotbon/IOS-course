//
//  Theme.swift
//  Scrumdinger
//
//  Created by Ashot Harutyunyan on 2024-03-05.
//
import SwiftUI
enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }

    var mainColor: Color {
        switch self {
        case .bubblegum:
            return Color.pink // Define a custom color for bubblegum
        case .buttercup:
            return Color.yellow
        // Add cases for other themes with custom colors
        default:
            return Color(rawValue) // For standard SwiftUI colors
        }
    }

    var name: String {
        rawValue.capitalized
    }
}
