//
//  ContentView.swift
//  iController
//
//  Created by Farhad Arghavan on 2024-02-09.
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

struct DevicesAppsView: View {
    let fdevice: FDevice
    var body: some View {
        NavigationView{
            List{
                
                ForEach(fdevice.deviceAppsUser ?? [], id: \.bundleIdentifier){ app in
                    
                    VStack(alignment: .leading){
                        Text(app.displayName)
                            .font(.title).bold()
                        
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Bundle Identifier:")
                                .font(.caption)
                                .colorMultiply(.blue)
                            Text(app.bundleIdentifier)
                                .font(.caption)
//                            Spacer()
                        }
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Version:")
                                .font(.caption)
                                .colorMultiply(.blue)
                            Text(app.version)
                                .font(.caption)
                            
                        }
                        NavigationLink(destination: FilesView(fdevice: fdevice, app: app)) {
                            Text("Show Files")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 40)
                                .background(Color.white)
                                .cornerRadius(10)
//                                .padding(.horizontal)
                                
                            
                        }
                    }
                    
                    

                    
                }
                .padding(.vertical)
            }
            .frame(minWidth: 250)
            
        }
        
        if let tempApp = fdevice.deviceAppsUser?.first{
            FilesView(fdevice: fdevice, app: tempApp)
        }
        
    }
}

struct FilesView: View {
    let fdevice: FDevice
    let app: FDevice.App

    var body: some View {
        VStack{

            Text("Files for \(app.displayName)")
            
            List{
                
            }.task {
//                let resultAppFilesMakeDir = try? iCA.shared.safeShell("cd ~/iControllerDoc/ && mkdir .doc_\(app.bundleIdentifier)")
//                print(resultAppFilesMakeDir ?? "")
//                let resultAppFiles = try? iCA.shared.safeShell("cd ~/iControllerDoc/ && /usr/local/bin/ifuse -u \(fdevice.uuid ?? "") --documents \(app.bundleIdentifier) .doc_\(app.bundleIdentifier) ")
//                print(resultAppFiles ?? "")
                
//                try? iCA.shared.safeShell("cd ~/iControllerDoc/ && rm .doc_\(app.bundleIdentifier)/Downloads/XYplorer.v25.50.0200_p30download.com.rar")
                
                
                // .task{
                // --bundle_id
            }
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
        .frame(width: 800, height: 700, alignment: .center)
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



struct ContentView: View {
    let backgroundGradient = LinearGradient(
        colors: [Color.red, Color.blue],
        startPoint: .top, endPoint: .bottom)
    
    @State var fDevices:[FDevice] = []
    @State var fLoadingDevices = false
    @State private var selectedDeviceUUID: String?

    var body: some View {
        NavigationView {
            List {
                ForEach(fDevices, id: \.uuid) { fd in
                    FDeviceSideItemView(fd: fd)
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200, idealWidth: 250, maxWidth: 300, maxHeight: .infinity)
            .navigationTitle("Devices")
            
            if fLoadingDevices {
                ProgressView("Loading devices")
                    .padding(8)
            } else {
                if let fd = fDevices.first{
                    DevicesAppsView(fdevice: fd)
                        
                }
            }
            
        }
        .navigationTitle("iDesk!")
        .task {
            await loadDevices()
        }
    }
    
    func loadDevices() async {
        if let cacheDevices: [FDevice] = load(from: "devices.json", as: [FDevice].self) {
            self.fDevices = cacheDevices
        } else {
            self.fLoadingDevices = true
            self.fDevices = iDeskApp.shared.loadDevicesConnectedList(loadApps: true)
            self.fLoadingDevices = false
            
            save(data: self.fDevices, to: "devices.json")
            
            if let firstDeviceUUID = fDevices.first?.uuid {
                self.selectedDeviceUUID = firstDeviceUUID
            }
        }

    }
    
}





