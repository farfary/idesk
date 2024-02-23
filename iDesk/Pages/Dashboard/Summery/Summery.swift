//
//  FAPageSummery.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import Foundation


struct SummeryView: View {
    let fdevice: FDevice
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "iphone")
                Label("Apps", systemImage: "info")
            }
        }
    }
}
