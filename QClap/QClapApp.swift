//
//  QClapApp.swift
//  QClap
//
//  Created by Daniel Hou on 12/6/22.
//

import SwiftUI

@main
struct QClapApp: App {
    var body: some Scene {
        WindowGroup {
            ClapperBoardView(production: "", sceneNumber: "1", takeNumber: "1", rollNumber: 1, cameraNumber: "CAM1")
        }
    }
}
