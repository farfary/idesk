//
//  Dashboard.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-09.
//

import SwiftUI
import SwiftData
import Foundation


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
//                if let fd = fDevices.first{
//                    DevicesAppsView(fdevice: fd)
//                        
//                }
                
                if let fd = fDevices.first{
                    SummeryView(fdevice: fd)

                }
            }
            
        }
        .navigationTitle("iDesk!")
        .task {
            await loadDevices()
        }
    }
    
    func loadDevices() async {
//        if let cacheDevices: [FDevice] = load(from: "devices.json", as: [FDevice].self) {
//            self.fDevices = cacheDevices
//            iDeskApp.fDevices = self.fDevices
//            
//        } else {
            self.fLoadingDevices = true
        self.fDevices = await iDeskApp.shared.loadDevicesConnectedList(loadApps: false)
//            iDeskApp.fDevices = self.fDevices
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            self.fLoadingDevices = false
            
            save(data: self.fDevices, to: "devices.json")
            
            if let firstDeviceUUID = fDevices.first?.uuid {
                self.selectedDeviceUUID = firstDeviceUUID
            }
//        }

    }
    
}



#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
        .frame(width: 800, height: 700, alignment: .center)
}

