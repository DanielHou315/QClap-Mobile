//
//  ProjectListView.swift
//  QClap
//
//  Created by Daniel Hou on 6/11/23.
//

import SwiftUI

struct ProjectListToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Save") {
                print("save document")
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            
            Button("Export") {
                print("exporting db")
            }
        }
    }
}

struct ProjectListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    Text("Detail")
                } label: {
                    Text("Hello, world!")
                }
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
