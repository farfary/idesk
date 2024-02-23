//
//  Apps.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import SwiftUI
import SwiftData
import Foundation


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
