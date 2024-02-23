//
//  Devices.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import SwiftUI
import SwiftData
import Foundation

struct DevicesView: View {
    let fdevice: FDevice
    var body: some View {
        HStack{
            VStack{
//                Image(.imageIPhone13Pro).frame(width: 150)
            }
            VStack{
                Text("iPhone 13 Pro")
            }
        }
//        ScrollView{
//            Text(iCA.shared.jsonPrintPrettyDeviceData(device: fdevice))
//        }
    }
}

struct FDeviceSideItemView: View {
    @State var fd: FDevice

    var body: some View {
        DisclosureGroup(
            isExpanded: $fd.isExpanded,
            content: {
                NavigationLink(destination: SummeryView(fdevice: fd)) {
                    Label("Summery", systemImage: "info.circle.fill")
                }
                NavigationLink(destination: DevicesAppsView(fdevice: fd)) {
                    Label("Apps", systemImage: "app.badge.fill")
                }
                NavigationLink(destination: DevicesView(fdevice: fd)) {
                    Label("Files", systemImage: "doc.fill")
                }
                NavigationLink(destination: DevicesView(fdevice: fd)) {
                    Label("Photos", systemImage: "photo.fill")
                }
                NavigationLink(destination: DevicesView(fdevice: fd)) {
                    Label("Musics", systemImage: "music.note.house.fill")
                }
                NavigationLink(destination: DevicesView(fdevice: fd)) {
                    Label("Movies", systemImage: "movieclapper.fill")
                }
            },
            label: {
                NavigationLink(destination: DevicesView(fdevice: fd)) {
                    VStack{
                        Label(fd.deviceData?.DeviceName ?? "", systemImage: "iphone")
                    }
                    
                }
                
                
            }
        )
    }
}
