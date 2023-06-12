//
//  GlobalSettingView.swift
//  QClap
//
//  Created by Daniel Hou on 6/11/23.
//

import SwiftUI

// --------------------
//
// Views
//
// --------------------


struct GlobalThemeSettingWidget: View {
    var body: some View {
        Text("Theme")
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.title2)
            .bold()
        Spacer().frame(minHeight:200)
        Divider()
    }
}







// --------------------
//
// Clapperboard
//
// --------------------
struct GlobalClapperboardSettingWidget: View {
    var body: some View {
        Text("Clapperboard")
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.title2)
            .bold()
        Spacer().frame(minHeight:200)
        Divider()
    }
}








// --------------------
//
// Sync
//
// --------------------
// Sync to iCloud Setting Widget
struct SynciCloudSettingWidget: View {
    var body: some View {
        HStack {
            Text("Sync to iCloud")
                .padding(.horizontal,20)
                .padding(.vertical, 5)
            Spacer()
            Button("Sync") {
                print("Sync to iCloud Button")
            }
        }
    }
}


struct ThirdPartyBackupSettingWidget: View {
    var body: some View {
        HStack {
            Text("3rd Party Cloud Backup")
                .padding(.horizontal,20)
                .padding(.vertical, 5)
            Spacer()
            Button("Sync") {
                print("Choose Provider")
            }
        }
    }
}


struct GlobalSyncSettingWidget: View {
    var body: some View {
        Text("Sync")
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.title2)
            .bold()
        VStack {
            SynciCloudSettingWidget()
            ThirdPartyBackupSettingWidget()
        }
        
        // Spacer().frame(minHeight:10)
        Divider()
    }
}








// --------------------
//
// Projects
//
// --------------------
struct GlobalProjectSettingWidget: View {
    var body: some View {
        Text("Projects")
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.title2)
            .bold()
        Spacer().frame(minHeight:200)
        Divider()
    }
}








// --------------------
//
// Purchase
//
// --------------------
struct GlobalPurchaseSettingWidget: View {
    var body: some View {
        Text("Upgrade to Pro")
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.title2)
            .bold()
        Spacer().frame(minHeight:200)
        Divider()
    }
}




// --------------------
//
// Total Global Settings
//
// --------------------
struct GlobalSettingView: View {
    var body: some View {
        NavigationStack {
            Divider()
            ScrollView{
                VStack{
                    GlobalClapperboardSettingWidget()
                    GlobalProjectSettingWidget()
                    GlobalSyncSettingWidget()
                    GlobalPurchaseSettingWidget()
                 }
            }
            .padding()
            .navigationTitle("Global Settings")
        }
    }
}

struct GlobalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalSettingView()
    }
}
