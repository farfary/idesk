//
//  DeviceShell.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-10.
//

import SwiftUI
import SwiftData
import Foundation



class FDevice: Identifiable, Codable{
    
    var uuid: String? = nil
    
    var isExpanded = true
    
    var isConnectingUSB: Bool? = nil
    var isConnectingNET: Bool? = nil
    
    var deviceData: DeviceData? = nil
    var deviceAppsAll: [App]? = nil
    var deviceAppsSystem: [App]? = nil
    var deviceAppsUser: [App]? = nil
    var batteryInfo: FABatteryInfo? = nil
    
    

    
    init(uuid: String? = nil, isConnectingUSB: Bool? = nil, isConnectingNET: Bool? = nil, deviceData: DeviceData? = nil, deviceAppsAll: [App]? = nil, deviceAppsSystem: [App]? = nil, deviceAppsUser: [App]? = nil) {
        self.uuid = uuid
        self.isConnectingUSB = isConnectingUSB
        self.isConnectingNET = isConnectingNET
        self.deviceData = deviceData
        self.deviceAppsAll = deviceAppsAll
        self.deviceAppsSystem = deviceAppsSystem
        self.deviceAppsUser = deviceAppsUser
    }
    
    
    struct DeviceData: Codable {
        var ActivationState: String?
        var BasebandActivationTicketVersion: String?
        var BasebandCertId: Int?
        var BasebandChipID: Int?
        var BasebandKeyHashInformation: BasebandKeyHashInformation?
        var BasebandMasterKeyHash: String?
        var BasebandRegionSKU: String?
        var BasebandSerialNumber: String?
        var BasebandStatus: String?
        var BasebandVersion: String?
        var BluetoothAddress: String?
        var BoardId: Int?
        var BootSessionID: String?
        var BrickState: Bool?
        var BuildVersion: String?
        var CPUArchitecture: String?
        var CarrierBundleInfoArray: [CarrierBundleInfo]?
        var CertID: Int?
        var ChipID: Int?
        var ChipSerialNo: String?
        var DeviceClass: String?
        var DeviceColor: Int?
        var DeviceName: String?
        var DieID: Int?
        var EthernetAddress: String?
        var FirmwareVersion: String?
        var FusingStatus: Int?
        var GID1: String?
        var GID2: String?
        var HardwareModel: String?
        var HardwarePlatform: String?
        var HasSiDP: Bool?
        var HostAttached: Bool?
        var HumanReadableProductVersionString: String?
        var IntegratedCircuitCardIdentity: String?
        var InternationalMobileEquipmentIdentity: String?
        var InternationalMobileSubscriberIdentity: String?
        var InternationalMobileSubscriberIdentityOverride: Bool?
        var MLBSerialNumber: String?
        var MobileSubscriberCountryCode: Int?
        var MobileSubscriberNetworkCode: Int?
        var ModelNumber: String?
        var NonVolatileRAM: NonVolatileRAM?
        var PRIVersion_Major: Int?
        var PRIVersion_Minor: Int?
        var PRIVersion_ReleaseNo: Int?
        var PairRecordProtectionClass: Int?
        var PartitionType: String?
        var PasswordProtected: Bool?
        var PkHash: String?
        var ProductName: String?
        var ProductType: String?
        var ProductVersion: String?
        var ProductionSOC: Bool?
        var ProtocolVersion: Int?
        var ProximitySensorCalibration: String?
        var RegionInfo: String?
        var SIMGID1: String?
        var SIMGID2: String?
        var SIMStatus: String?
        var SIMTrayStatus: String?
        var SerialNumber: String?
        var SoftwareBehavior: String?
        var SoftwareBundleVersion: String?
        var SupportedDeviceFamilies: [Int]?
        var TelephonyCapability: Bool?
        var TimeIntervalSince1970: Double?
        var TimeZone: String?
        var TimeZoneOffsetFromUTC: Double?
        var TrustedHostAttached: Bool?
        var UniqueChipID: Int?
        var UniqueDeviceID: String?
        var UseRaptorCerts: Bool?
        var Uses24HourClock: Bool?
        var WiFiAddress: String?
        var iTunesHasConnected: Bool?
        var kCTPostponementInfoPRIVersion: String?
        var kCTPostponementInfoServiceProvisioningState: Bool?
        var kCTPostponementStatus: String?
    }

    struct BasebandKeyHashInformation: Codable {
        var AKeyStatus: Int?
        var SKeyHash: String?
        var SKeyStatus: Int?
    }

    struct CarrierBundleInfo: Codable {
        var CFBundleIdentifier: String?
        var CFBundleVersion: String?
        var GID1: String?
        var GID2: String?
        var IntegratedCircuitCardIdentity: String?
        var InternationalMobileSubscriberIdentity: String?
        var MCC: Int?
        var MNC: Int?
        var SIMGID1: String?
        var SIMGID2: String?
        var Slot: String?
        var kCTPostponementInfoAvailable: String?
    }

    struct NonVolatileRAM: Codable {
        var StartupMute: String?
        var SystemAudioVolumeSaved: String?
        var autoBoot: String?
        var backlightLevel: String?
        var backlightNits: String?
        var bootArgs: String?
        var bootdelay: String?
        var comAppleSystemFpState: String?
        var fmAccountMasked: String?
        var fmActivationLocked: String?
        var fmSpkeys: String?
        var obliteration: String?
        var otaControllerVersion: String?
        var otaOriginalBaseOsVersion: String?
        var usbcfwflasherResult: String?
        var nonceSeeds: String?
    }

    struct App: Codable {
        var bundleIdentifier: String
        var version: String
        var displayName: String
    }
    
    
    
    
    
    
    
    
    
    
    
    @discardableResult // Add to suppress warnings when you don't want/need a result
    func safeShell(_ command: String) throws -> String {
        
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh") //<--updated
        task.standardInput = nil

        try task.run() //<--updated
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }

    func parseDeviceDataLine(_ line: String) -> (String, String?) {
        let components = line.components(separatedBy: ": ")
        guard let key = components.first else { return ("", nil) }
        let value = components.count > 1 ? components[1] : nil
        return (key, value)
    }

    func readDeviceData(from text: String) -> DeviceData {
        var deviceData = DeviceData()
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












