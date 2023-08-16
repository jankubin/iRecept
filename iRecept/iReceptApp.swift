//
//  iReceptApp.swift
//  iRecept
//
//  Created by Jan Kubín on 17.07.2023.
//

import SwiftUI

@main
struct iReceptApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
