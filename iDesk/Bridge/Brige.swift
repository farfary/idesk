//
//  Brige.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import Foundation


extension iDeskApp{
    
    func jsonPrintPrettyDeviceData(device: FDevice) -> String{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            // Try to encode the person instance into JSON data
            let jsonData = try encoder.encode(device.deviceData)
            
            // Convert the JSON data into a string with UTF-8 encoding
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            // Handle error
            print("Error encoding JSON: \(error)")
        }
        
        return "nil"
    }
    
    func loadDevicesConnectedList(loadApps: Bool = false) -> [FDevice]{
//        let resultBAT = try? safeShell("/usr/local/bin/")
        let resultUSB = try? safeShell("/usr/local/bin/idevice_id -l")
        let resultNET = try? safeShell("/usr/local/bin/idevice_id -n")
        
        
        
//        print(resultUSB)
//        print(resultNET)

        var listDevices: [FDevice] = []
        
        resultUSB?.enumerateLines { uuid, _ in
            iDeskApp.logger.log(device: uuid, action: "Connected USB")
            
            var fd = FDevice()
            fd.uuid = uuid
            
            let resultDeviceInfo = try! safeShell("/usr/local/bin/ideviceinfo -u \(uuid)")
            let deviceData = readDeviceData(from: resultDeviceInfo)
            fd.deviceData = deviceData
            
            let resultBAT1 = try? safeShell("/usr/local/bin/idevicediagnostics ioregentry AppleARMPMUCharger")
            let resultBAT2 = try? safeShell("/usr/local/bin/idevicediagnostics ioregentry AppleSmartBattery")
            
            print(resultBAT1)
            print(resultBAT2)
            
            if loadApps{
                // Load Apps All
                if let resultDeviceAppsAll = try? safeShell("/usr/local/bin/ideviceinstaller -u \(uuid) -l -o list_all"){
                    let deviceAppsAll = parseAppData(from: resultDeviceAppsAll)
                    fd.deviceAppsAll = deviceAppsAll
                }
                
                
                // Load Apps System
                if let resultDeviceAppsSystem = try? safeShell("/usr/local/bin/ideviceinstaller -u \(uuid) -l -o list_system"){
                    let deviceAppsSystem = parseAppData(from: resultDeviceAppsSystem)
                    fd.deviceAppsSystem = deviceAppsSystem
                }
                
                
                // Load Apps User
                if let resultDeviceAppsUser = try? safeShell("/usr/local/bin/ideviceinstaller -u \(uuid) -l -o list_user"){
                    let deviceAppsUser = parseAppData(from: resultDeviceAppsUser)
                    fd.deviceAppsUser = deviceAppsUser
                }
            }
            
            
            listDevices.append(fd)
        }
        
//        for device in listDevices{
//
//        }
        
        return listDevices
    }
    
    func parseAppData(from text: String) -> [FDevice.App] {
        let lines = text.split(separator: "\n")
        var apps: [FDevice.App] = []
        
        // Start from 1 to skip the header line
        for line in lines.dropFirst() {
            let components = line.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: false)
            guard components.count == 3 else { continue }
            
            let bundleIdentifier = components[0].trimmingCharacters(in: .whitespaces)
            let version = components[1].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: CharacterSet(charactersIn: "\""))
            let displayName = components[2].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: CharacterSet(charactersIn: "\""))
            
            let app = FDevice.App(bundleIdentifier: bundleIdentifier, version: version, displayName: displayName)
            apps.append(app)
        }
        
        return apps
    }
    
    func parseDeviceDataLine(_ line: String) -> (String, String?) {
        let components = line.components(separatedBy: ": ")
        guard let key = components.first else { return ("", nil) }
        let value = components.count > 1 ? components[1] : nil
        return (key, value)
    }
    
    func readDeviceData(from text: String) -> FDevice.DeviceData {
        var deviceData = FDevice.DeviceData()
        let lines = text.split(separator: "\n")
        for line in lines {
            let (key, value) = parseDeviceDataLine(String(line))
            switch key {
            case "ActivationState":
                deviceData.ActivationState = value
            case "BasebandActivationTicketVersion":
                deviceData.BasebandActivationTicketVersion = value
            case "BasebandCertId":
                deviceData.BasebandCertId = Int(value ?? "")
            case "BasebandChipID":
                deviceData.BasebandChipID = Int(value ?? "")
            case "BasebandKeyHashInformation":
                // Implement parsing of nested struct
                break
            case "BasebandMasterKeyHash":
                deviceData.BasebandMasterKeyHash = value
            case "BasebandRegionSKU":
                deviceData.BasebandRegionSKU = value
            case "BasebandSerialNumber":
                deviceData.BasebandSerialNumber = value
            case "BasebandStatus":
                deviceData.BasebandStatus = value
            case "BasebandVersion":
                deviceData.BasebandVersion = value
            case "BluetoothAddress":
                deviceData.BluetoothAddress = value
            case "BoardId":
                deviceData.BoardId = Int(value ?? "")
            case "BootSessionID":
                deviceData.BootSessionID = value
            case "BrickState":
                deviceData.BrickState = value == "true" ? true : false
            case "BuildVersion":
                deviceData.BuildVersion = value
            case "CPUArchitecture":
                deviceData.CPUArchitecture = value
            case "CarrierBundleInfoArray[1]":
                // Implement parsing of nested struct array
                break
            case "CertID":
                deviceData.CertID = Int(value ?? "")
            case "ChipID":
                deviceData.ChipID = Int(value ?? "")
            case "ChipSerialNo":
                deviceData.ChipSerialNo = value
            case "DeviceClass":
                deviceData.DeviceClass = value
            case "DeviceColor":
                deviceData.DeviceColor = Int(value ?? "")
            case "DeviceName":
                deviceData.DeviceName = value
            case "DieID":
                deviceData.DieID = Int(value ?? "")
            case "EthernetAddress":
                deviceData.EthernetAddress = value
            case "FirmwareVersion":
                deviceData.FirmwareVersion = value
            case "FusingStatus":
                deviceData.FusingStatus = Int(value ?? "")
            case "GID1":
                deviceData.GID1 = value
            case "GID2":
                deviceData.GID2 = value
            case "HardwareModel":
                deviceData.HardwareModel = value
            case "HardwarePlatform":
                deviceData.HardwarePlatform = value
            case "HasSiDP":
                deviceData.HasSiDP = value == "true" ? true : false
            case "HostAttached":
                deviceData.HostAttached = value == "true" ? true : false
            case "HumanReadableProductVersionString":
                deviceData.HumanReadableProductVersionString = value
            case "IntegratedCircuitCardIdentity":
                deviceData.IntegratedCircuitCardIdentity = value
            case "InternationalMobileEquipmentIdentity":
                deviceData.InternationalMobileEquipmentIdentity = value
            case "InternationalMobileSubscriberIdentity":
                deviceData.InternationalMobileSubscriberIdentity = value
            case "InternationalMobileSubscriberIdentityOverride":
                deviceData.InternationalMobileSubscriberIdentityOverride = value == "true" ? true : false
            case "MLBSerialNumber":
                deviceData.MLBSerialNumber = value
            case "MobileSubscriberCountryCode":
                deviceData.MobileSubscriberCountryCode = Int(value ?? "")
            case "MobileSubscriberNetworkCode":
                deviceData.MobileSubscriberNetworkCode = Int(value ?? "")
            case "ModelNumber":
                deviceData.ModelNumber = value
            case "NonVolatileRAM":
                // Implement parsing of nested struct
                break
            case "PRIVersion_Major":
                deviceData.PRIVersion_Major = Int(value ?? "")
            case "PRIVersion_Minor":
                deviceData.PRIVersion_Minor = Int(value ?? "")
            case "PRIVersion_ReleaseNo":
                deviceData.PRIVersion_ReleaseNo = Int(value ?? "")
            case "PairRecordProtectionClass":
                deviceData.PairRecordProtectionClass = Int(value ?? "")
            case "PartitionType":
                deviceData.PartitionType = value
            case "PasswordProtected":
                deviceData.PasswordProtected = value == "true" ? true : false
            case "PkHash":
                deviceData.PkHash = value
            case "ProductName":
                deviceData.ProductName = value
            case "ProductType":
                deviceData.ProductType = value
            case "ProductVersion":
                deviceData.ProductVersion = value
            case "ProductionSOC":
                deviceData.ProductionSOC = value == "true" ? true : false
            case "ProtocolVersion":
                deviceData.ProtocolVersion = Int(value ?? "")
            case "ProximitySensorCalibration":
                deviceData.ProximitySensorCalibration = value
            case "RegionInfo":
                deviceData.RegionInfo = value
            case "SIMGID1":
                deviceData.SIMGID1 = value
            case "SIMGID2":
                deviceData.SIMGID2 = value
            case "SIMStatus":
                deviceData.SIMStatus = value
            case "SIMTrayStatus":
                deviceData.SIMTrayStatus = value
            case "SerialNumber":
                deviceData.SerialNumber = value
            case "SoftwareBehavior":
                deviceData.SoftwareBehavior = value
            case "SoftwareBundleVersion":
                deviceData.SoftwareBundleVersion = value
            case "SupportedDeviceFamilies[1]":
                // Implement parsing of nested array
                break
            case "TelephonyCapability":
                deviceData.TelephonyCapability = value == "true" ? true : false
            case "TimeIntervalSince1970":
                deviceData.TimeIntervalSince1970 = Double(value ?? "")
            case "TimeZone":
                deviceData.TimeZone = value
            case "TimeZoneOffsetFromUTC":
                deviceData.TimeZoneOffsetFromUTC = Double(value ?? "")
            case "TrustedHostAttached":
                deviceData.TrustedHostAttached = value == "true" ? true : false
            case "UniqueChipID":
                deviceData.UniqueChipID = Int(value ?? "")
            case "UniqueDeviceID":
                deviceData.UniqueDeviceID = value
            case "UseRaptorCerts":
                deviceData.UseRaptorCerts = value == "true" ? true : false
            case "Uses24HourClock":
                deviceData.Uses24HourClock = value == "true" ? true : false
            case "WiFiAddress":
                deviceData.WiFiAddress = value
            case "iTunesHasConnected":
                deviceData.iTunesHasConnected = value == "true" ? true : false
            case "kCTPostponementInfoPRIVersion":
                deviceData.kCTPostponementInfoPRIVersion = value
            case "kCTPostponementInfoServiceProvisioningState":
                deviceData.kCTPostponementInfoServiceProvisioningState = value == "true" ? true : false
            case "kCTPostponementStatus":
                deviceData.kCTPostponementStatus = value
            default:
                break
            }
        }
        return deviceData
    }

}
