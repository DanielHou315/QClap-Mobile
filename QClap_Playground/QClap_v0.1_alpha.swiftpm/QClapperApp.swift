//
//  QClapperApp.swift
//  QClapper
//
//  Created by Daniel Hou on 12/6/22.
//

import SwiftUI

@main
struct QClapperApp: App {
    var body: some Scene {
        WindowGroup {
            ClapperBoardView(production: "annarborbreak", sceneNumber: "1", takeNumber: "1A", rollNumber: 1, cameraNumber: "CAM1")
        }
    }
}
