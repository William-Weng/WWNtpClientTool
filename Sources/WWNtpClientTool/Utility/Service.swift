//
//  Service.swift
//  WWNtpClientTool
//
//  Created by William.Weng on 2026/6/4.
//

import Foundation
import WWNtpClient

extension WWNtpClientTool {
    
    /// 提供 NTP 查詢服務的類別
    /// - Note: 標記為 Sendable，表示可安全在 Swift Concurrency 中跨執行緒使用
    final class Service: Sendable {
              
        private let formatterActor = FormatterActor()
        
        init() {}
        
        /// 取得目前 NTP 時間
        /// - Parameter timeZoneIdentifier: 可選的時區識別碼（如 "America/New_York"）
        /// - Returns: 本地化的時間字串
        /// - Throws: 若發生嚴重錯誤則拋出
        func date(timeZoneIdentifier: String? = nil) async throws -> String {
            
            let info = try await WWNtpClient.shared.connect().get()
            var timeZone: TimeZone?
                        
            if let timeZoneIdentifier { timeZone = TimeZone(identifier: timeZoneIdentifier) }
            return await formatterActor.format(date: info.date, timeZone: timeZone ?? .autoupdatingCurrent)
        }
    }
}

private extension WWNtpClientTool {
    
    actor FormatterActor {
        
        private let formatter = DateFormatter()
        
        /// 將 Date 轉成本地化時間字串
        /// - Parameters:
        ///   - date: 要格式化的日期時間
        ///   - timeZone: 目標時區
        /// - Returns: 本地化的時間字串（根據使用者當前地區與時區）
        func format(date: Date, timeZone: TimeZone) -> String {
            
            formatter.locale = .current
            formatter.timeZone = timeZone
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
            
            return formatter.string(from: date)
        }
    }
}
