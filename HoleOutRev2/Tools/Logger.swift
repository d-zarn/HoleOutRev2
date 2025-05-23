/**
 Provides basic logging for debugging
 */

import Foundation
import SwiftUI

enum LogLevel: String {
    case info = "ℹ️"
    case success = "✅"
    case warning = "⚠️"
    case error = "❌"
    
    var textColor: Color {
        switch self {
        case .info: return .blue
        case .success: return .green
        case .warning: return .orange
        case .error: return .red
        }
    }
}

class Logger {
    
    func log(_ message: String, level: LogLevel = .info, function: String = #function, file: String = #file, line: Int = #line) {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        let logMessage = " [\(timestamp)] \(level.rawValue) \(file) \(function) Line \(line): \(message)"

        print(logMessage)
        
        #if DEBUG
        #endif
    }
    
    func formatOptional<T>(_ value: T?, defaultvalue: String = "nil") -> String {
        if let value = value {
            return "\(value)"
        }
        return defaultvalue
    }
}
