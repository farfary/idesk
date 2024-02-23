//
//  AppsFiles.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import Foundation

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
