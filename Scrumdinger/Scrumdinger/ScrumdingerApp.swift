//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Ashot Harutyunyan on 2024-03-04.
//

import SwiftUI


@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
           // MeetingView()
        }
    }
}
