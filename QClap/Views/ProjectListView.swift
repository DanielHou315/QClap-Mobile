//
//  ProjectListView.swift
//  QClap
//
//  Created by Daniel Hou on 6/11/23.
//

import SwiftUI

struct ProjectListToolbar: ToolbarContent {
    var body: some ToolbarContent {
        
        // Projects Page Notification Popup
        ToolbarItem {
            NotificationButton()
        }
        // Project Page Settings Button (Global)
        ToolbarItem {
            GlobalSettingButton()
        }
    }
}

struct ProjectListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Projects")
            }
            .toolbar {
                ProjectListToolbar()
            }
            .padding()
            .navigationTitle("Projects")
            // .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView()
    }
}
