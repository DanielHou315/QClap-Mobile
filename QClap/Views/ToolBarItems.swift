//
//  ToolBarItems.swift
//  QClap
//
//  Created by Daniel Hou on 6/12/23.
//

import SwiftUI


struct NotificationButton: View {
    var body: some View {
        Button (
            action: {
                print("notifications")
            },
            label: {
                Image(systemName: "bell")
            }
        )
    }
}

struct GlobalSettingButton: View {
    var body: some View {
        Button (
            action: {
                print("Global Settings")
            },
            label: {
                Image(systemName: "gear")
            }
        )
    }
}

struct ProjectSettingButton: View {
    var body: some View {
        Button (
            action: {
                print("Project Settings")
            },
            label: {
                Image(systemName: "gear")
            }
        )
    }
}

struct ProjectShareButton: View {
    var body: some View {
        Button (
            action: {
                print("Share Project")
            },
            label: {
                Image(systemName: "square.and.arrow.up")
            }
        )
    }
}

struct ToolBarItemCollection: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            NotificationButton()
            GlobalSettingButton()
            ProjectSettingButton()
            ProjectShareButton()
        }
    }
}



struct ToolBarItems: View {
    var body: some View {
        NavigationStack {
            VStack{
                Text("ToolBarItems Test")
            }
            .padding()
            .toolbar (
                content: {ToolBarItemCollection()}
            )
        }
    }
}

//
struct ToolBarItems_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarItems()
    }
}
