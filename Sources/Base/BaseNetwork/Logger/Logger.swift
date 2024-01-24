//
//  AlamofireLogger.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 29/08/2023.
//

import Foundation
import XCGLogger

private let log = XCGLogger.default // swiftlint:disable:this prefixed_toplevel_constant

public final class Logger {
    
#if ENDPOINT_DEBUG
    let logLevel = XCGLogger.Level.debug
#else
    let logLevel = XCGLogger.Level.none
#endif
    
    private let logURL: URL
    public static let shared = Logger()
    
    init() {
        let arrayPaths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let cacheDirectoryPath = arrayPaths[0]
        logURL = cacheDirectoryPath.appendingPathComponent(UUID().uuidString)
    }
    
    public func getFile() -> URL {
        return logURL
    }
    
    public func setUpLog() {
        let fileDestination = FileDestination(writeToFile: getFile(), identifier: "advancedLogger.fileDestination")
        log.add(destination: fileDestination)
        log.logAppDetails()
        
        log.setup(level: logLevel,
                  showLogIdentifier: false,
                  showFunctionName: true,
                  showThreadName: false,
                  showLevel: true,
                  showFileNames: true,
                  showLineNumbers: true,
                  showDate: true,
                  writeToFile: nil,
                  fileLevel: nil)
        
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
        log.formatters = [emojiLogFormatter]
    }
}

public func LogVerbose(_ closure: @autoclosure @escaping () -> Any?,
                       functionName: StaticString = #function,
                       fileName: StaticString = #file,
                       lineNumber: Int = #line,
                       userInfo: [String: Any] = [:]) {
    log.logln(.verbose,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}

public func LogDebug(_ closure: @autoclosure @escaping () -> Any?,
                     functionName: StaticString = #function,
                     fileName: StaticString = #file,
                     lineNumber: Int = #line,
                     userInfo: [String: Any] = [:]) {
    log.logln(.debug,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}

public func LogInfo(_ closure: @autoclosure @escaping () -> Any?,
                    functionName: StaticString = #function,
                    fileName: StaticString = #file,
                    lineNumber: Int = #line,
                    userInfo: [String: Any] = [:]) {
    log.logln(.info,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}

public func LogWarn(_ closure: @autoclosure @escaping () -> Any?,
                    functionName: StaticString = #function,
                    fileName: StaticString = #file,
                    lineNumber: Int = #line,
                    userInfo: [String: Any] = [:]) {
    log.logln(.warning,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}

public func LogError(_ closure: @autoclosure @escaping () -> Any?,
                     functionName: StaticString = #function,
                     fileName: StaticString = #file,
                     lineNumber: Int = #line,
                     userInfo: [String: Any] = [:]) {
    log.logln(.error,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}
