//
//  AppLogger.swift
//  iDesk
//
//  Created by Farhad Arghavan on 2024-02-09.
//

import Foundation

class AppLogger {
    private let startTimestamp: Date
    private let dateFormatter: DateFormatter
    private let fileManager: FileManager
    private var logFilePath: String

    init() {
        self.fileManager = FileManager.default
        self.startTimestamp = Date()
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        
        let startTimeString = dateFormatter.string(from: startTimestamp)
        let logFileName = "AppLog_\(startTimeString).log"
        if let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let logFileURL = documentsPath.appendingPathComponent(logFileName)
            self.logFilePath = logFileURL.path
        } else {
            self.logFilePath = NSTemporaryDirectory().appending(logFileName)
        }

        // Initial log entry
        log(device: "AppStart", action: "Application started")
    }

    func log(device: String?, action: String) {
        let currentTimestamp = Date()
        let timestampString = dateFormatter.string(from: currentTimestamp)
        let logEntry = "[\(timestampString)] [Device: \(device ?? "none")] \(action)"

        print(logEntry)

    
        if !fileManager.fileExists(atPath: logFilePath) {
            fileManager.createFile(atPath: logFilePath, contents: nil)
        }
        
        if let fileHandle = FileHandle(forWritingAtPath: logFilePath) {
            defer { fileHandle.closeFile() }
            fileHandle.seekToEndOfFile()
            if let data = logEntry.data(using: .utf8) {
                fileHandle.write(data)
            }
        } else {
            print("Failed to open log file for writing.")
        }
    }
}
