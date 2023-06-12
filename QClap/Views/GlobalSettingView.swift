//
//  GlobalSettingView.swift
//  QClap
//
//  Created by Daniel Hou on 6/11/23.
//

import SwiftUI


//struct GlobalSettingButton: ToolBarItem {
//    var body: some ToolbarItem {
//
//    }
//}


struct GlobalSettingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    Text("Detail")
                } label: {
                    Text("Global Settings")
                }
            }
            .padding()
            .navigationTitle("Global Settings")
            // .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GlobalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalSettingView()
    }
}
