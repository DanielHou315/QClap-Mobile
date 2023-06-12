//
//  ProjectListView.swift
//  QClap
//
//  Created by Daniel Hou on 6/11/23.
//

import SwiftUI

struct ProjectListToolbar: ToolbarContent {
    var body: some ToolbarContent {
//        ToolbarItem(placement: .navigationBarLeading) {
//            Button("Save") {
//                print("save document")
//            }
//        }
        
        // Projects PageNotification Popup
        ToolbarItem {
            Button(
                action: {
                    print("notifications")
                },
                label: {
                    Image(systemName: "bell")
                }
            )
        }
        
        // Share Database Button
        ToolbarItem {
            Button(
                action: {
                    print("export")
                },
                label: {
                    Image(systemName: "square.and.arrow.up")
                }
            )
        }
        
        // Project Page Settings Button (Global)
        ToolbarItem {
            Button(
                action: {
                    print("dir->settings")
                },
                label: {
                    Image(systemName: "gearshape")
                    // Text("Settings")
                }
            )
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
