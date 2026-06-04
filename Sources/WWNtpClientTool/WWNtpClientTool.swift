//
//  WWNtpClientTool.swift
//  WWNtpClientTool
//
//  Created by William.Weng on 2026/6/4.
//

import FoundationModels

/// NTP 時間查詢 Tool，用於取得網路時間伺服器目前時間
public struct WWNtpClientTool: Tool {
    
    /// Tool 名稱，用於 AI 識別與呼叫
    public var name: String = "ntpClient"
    
    /// Tool 描述，說明其用途與功能
    public var description: String = """
    Retrieves the current time from an NTP (Network Time Protocol) server.
        
        IMPORTANT USAGE:
        - When the user asks for time in a specific location/country/city, ALWAYS provide the timeZone parameter
        - Default behavior (no timeZone): returns time in the device's local timezone
        - With timeZone parameter: returns time converted to the specified timezone
        
        COMMON USE CASES:
        - "What time is it now?" → call without timeZone (uses local time)
        - "What time is it in America/New York?" → call with timeZone: "America/New_York"
        - "What time is it in the US?" → call with timeZone: "America/New_York" (US Eastern Time)
        - "What time is it in Los Angeles?" → call with timeZone: "America/Los_Angeles"
        - "What time is it in London?" → call with timeZone: "Europe/London"
        - "What time is it in Tokyo?" → call with timeZone: "Asia/Tokyo"
        
        Returns the time in a localized format (e.g., "June 4, 2026 at 3:30:00 PM").
        Returns an error description if the connection fails.
    """
    
    /// NTP 服務實例（用於查詢時間）
    private let service = Service()
    
    /// 初始化 Tool
    public init() {}
}

extension WWNtpClientTool {
    
    @Generable
    public struct Arguments: Sendable {
        
        public var timeZone: String?
        
        public init(timeZone: String) {
            self.timeZone = timeZone
        }
    }
}

public extension WWNtpClientTool {
    
    /// 呼叫 NTP Tool 取得時間
    /// - Parameters:
    ///   - arguments: NTP 查詢參數（目前不需要參數）
    /// - Returns: 包含時間字串的陣列
    /// - Throws: 若發生嚴重錯誤則拋出
    func call(arguments: Arguments) async throws -> [String] {
        let date = try await service.date(timeZoneIdentifier: arguments.timeZone)
        return [date]
    }
}
