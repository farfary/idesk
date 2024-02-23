//
//  Summery.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import SwiftUI
import SwiftData
import Foundation


struct SummeryView: View {
    let fdevice: FDevice
    
    var body: some View {
        VStack{
            HStack{
                Text(fdevice.deviceData?.DeviceName ?? "")
                    .font(.title)
                    .fontDesign(.default)
                    .fontWeight(.bold)
                    .fontWidth(.standard)
                Spacer()
            }
            .padding()
            
            HStack(content: {
                VStack(alignment: .leading, spacing: 5, content: {
                    HStack{
                        Text("Serial Number")
                        Text(":")
                        Text(fdevice.deviceData?.SerialNumber ?? "")
                    }
                    HStack{
                        Text("Product Name")
                        Text(":")
                        Text(fdevice.deviceData?.ProductName ?? "")
                    }
                    HStack{
                        Text("Model Number")
                        Text(":")
                        Text(fdevice.deviceData?.ModelNumber ?? "")
                    }
                    HStack{
                        Text("Battery Current Capacity")
                        Text(":")
                        Text("\(fdevice.batteryInfo?.CurrentCapacity ?? 0) %")
                    }
                    
                    Spacer()
                })
                .padding()
                
                Spacer()
            })
            
            
            
            Spacer()
        }
        .frame(minWidth: 500, minHeight: 500)
        
        
    }
}

#Preview {
    SummeryView(fdevice: iDeskApp.fDevices.first!)
}
