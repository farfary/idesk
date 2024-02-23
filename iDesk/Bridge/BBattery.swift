//
//  BBattery.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-23.
//

import Foundation

import Foundation

struct BatteryData: Codable {
    struct LifetimeData: Codable {
        let AverageTemperature: Int
        let CycleCountLastQmax: Int
        let FlashEraseCounter: Int
        let FlashFailureCounter: Int
        let LTDataCorruptionOffset: Int
        let LTOCVRestCounter: Int
        let LTOCVRestCounterHsp: Int
        let LTQmaxUpdateCounter: Int
        let LTQmaxUpdateCounterHsp: Int
        let LowVoltageResidencyCounters: Data
        let MaximumChargeCurrent: Int
        let MaximumDischargeCurrent: Int
        let MaximumFCC: Int
        let MaximumPackVoltage: Int
        let MaximumQmax: Int
        let MaximumTemperature: Int
        let MinimumFCC: Int
        let MinimumPackVoltage: Int
        let MinimumQmax: Int
        let MinimumTemperature: Int
        let NCCMax: Int
        let NCCMin: Int
        let ResetCnt: Int
        let SafetyFaultCounter: Data
        let TemperatureSamples: Int
        let TimeAtHighSoc: Data
        let TotalOperatingTime: Int
        let UpdateTime: Int
    }

    let AlgoChemID: Int
    let AlgoTemperature: Int
    let BatteryHealthMetric: Int
    let CellCurrentAccumulator: [Int]
    let CellCurrentAccumulatorCount: Int
    let CellVoltage: [Int]
    let CellWom: [Int]
    let ChargeAccum: Int
    let ChemID: Int
    let ChemicalWeightedRa: Int
    let CycleCount: Int
    let DOD0: [Int]
    let DODatEOC: Int
    let DailyMaxSoc: Int
    let DailyMinSoc: Int
    let DateOfFirstUse: Int
    let DesignCapacity: Int
    let Dod0AtQualifiedQmax: Int
    let DynamicSoc1Vcut: Int
    let FccComp1: Int
    let FccComp2: Int
    let FilteredCurrent: Int
    let FilteredCurrentRc3: Int
    let FilteredCurrentRc4: Int
    let Flags: Int
    let GaugeFlagRaw: Int
    let GaugeResetCounter: Int
    let ISS: Int
    let ITMiscStatus: Int
    let LifetimeData: LifetimeData
    let ManufactureDate: Int
    let MaxCapacity: Int
    let MfgData: Data
    let PMUConfigured: Int
    let PackCurrentAccumulator: Int
    let PackCurrentAccumulatorCount: Int
    let PassedCharge: Int
    let PresentDOD: [Int]
    let Qmax: [Int]
    let QmaxDisqualificationReason: Int
    let Qstart: Int
    let RSS: Int
    let RSSFiltered: Int
    let Ra00: Int
    let Ra01: Int
    let Ra02: Int
    let Ra03: Int
    let Ra04: Int
    let Ra05: Int
    let Ra06: Int
    let Ra07: Int
    let Ra08: Int
    let Ra09: Int
    let Ra10: Int
    let Ra11: Int
    let Ra12: Int
    let Ra13: Int
    let Ra14: Int
    let RaTableRaw: [Data]
    let ResScale: Int
    let ResetData: Data
    let ResetDataComms: Int
    let ResetDataFirmware: Int
    let ResetDataHardware: Int
    let ResetDataSoftware: Int
    let ResetDataWatchDog: Int
    let Serial: String
    let SimRate: Int
    let Soc1Voltage: Int
    let StateOfCharge: Int
    let TrueRemainingCapacity: Int
    let UUID: Int
    let Voltage: Int
    let WatchdogDebugDump: Data
    let WeightedRa: [Int]
    let iMaxAndSocSmoothTable: Data
}

struct ChargerData: Codable {
    let ChargerID: Int
    let ChargerInhibitReason: Int
    let ChargerStatus: Data
    let ChargingCurrent: Int
    let ChargingVoltage: Int
    let NotChargingReason: Int
    let TimeChargingThermallyLimited: Int
    let VacVoltageLimit: Int
}

struct IOReportChannels: Codable {
    let BatteryCycleCount: [Int]
    let BatteryMaxTemp: [Int]
    let BatteryMinTemp: [Int]
    let BatteryMaxPackVoltage: [Int]
    let BatteryMinPackVoltage: [Int]
    let BatteryChargeCurrent: [Int]
    let BatteryDischargeCurrent: [Int]
    let BatteryOverChargedCurrent: [Int]
    let BatteryOverDischargedCurrent: [Int]
    let BatteryTemperature: [Int]
    let BatteryVoltage: [Int]
    let BatteryCell1Voltage: [Int]
    let BatteryCell2Voltage: [Int]
    let BatteryCell3Voltage: [Int]
    let BatteryCell4Voltage: [Int]
    let BatteryCell5Voltage: [Int]
    let BatteryCell6Voltage: [Int]
    let BatteryCell7Voltage: [Int]
    let BatteryCell8Voltage: [Int]
    let BatteryCell9Voltage: [Int]
    let BatteryCell10Voltage: [Int]
    let BatteryCell11Voltage: [Int]
    let BatteryCell12Voltage: [Int]
    let BatteryCell13Voltage: [Int]
    let BatteryCell14Voltage: [Int]
    let BatteryCell15Voltage: [Int]
    let BatteryCell16Voltage: [Int]
    let BatterySOC: [Int]
    let BatterySoh: [Int]
    let BatteryMaxErr: [Int]
    let BatteryMaxFullChgCap: [Int]
    let BatteryMaxFullDischgCap: [Int]
    let BatteryDesignCapacity: [Int]
    let BatteryQmaxFiltered: [Int]
    let BatteryCycleCountFiltered: [Int]
    let BatteryChargeCurrentFiltered: [Int]
    let BatteryDischargeCurrentFiltered: [Int]
    let BatteryMaxTempFiltered: [Int]
    let BatteryMinTempFiltered: [Int]
    let BatteryVoltageFiltered: [Int]
    let BatterySOCFiltered: [Int]
    let BatterySohFiltered: [Int]
    let BatteryMaxErrFiltered: [Int]
    let BatteryMaxFullChgCapFiltered: [Int]
    let BatteryMaxFullDischgCapFiltered: [Int]
    let BatteryDesignCapacityFiltered: [Int]
    let BatteryQmax: [Int]
    let ChargerID: [Int]
    let ChargerInhibitReason: [Int]
    let ChargerStatus: [Data]
    let ChargingCurrent: [Int]
    let ChargingVoltage: [Int]
    let NotChargingReason: [Int]
    let TimeChargingThermallyLimited: [Int]
    let VacVoltageLimit: [Int]
    let ChargerCycleCount: [Int]
    let ChargerMaxTemp: [Int]
    let ChargerMinTemp: [Int]
    let ChargerVoltage: [Int]
    let ChargerCurrent: [Int]
    let ChargerTemperature: [Int]
}

struct BatteryReport: Codable {
    let Data: [BatteryData]
    let Channels: IOReportChannels
}
