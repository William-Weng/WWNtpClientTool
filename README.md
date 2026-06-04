# [WWNtpClientTool](https://swiftpackageindex.com/William-Weng)

[![Swift-6.2](https://img.shields.io/badge/Swift-6.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![iOS-26.0](https://img.shields.io/badge/iOS-26.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWNtpClientTool)
[![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

[English](./README.en.md) | [繁體中文](./README.md)

---

`WWNtpClientTool` 是一個用來查詢 **NTP 網路時間** 的 Tool。

它可以根據指定的時區回傳目前時間字串，適合用在：
- 顯示本地時間
- 查詢其他國家或城市的時間
- 搭配 Foundation Models 的 Tool Calling 使用
- 讓 AI 根據使用者語意自動判斷要查詢哪個時區

---

## ✨ 功能特色

- 支援 NTP 時間查詢。
- 支援 IANA 時區，例如 `Asia/Taipei`、`America/New_York`。
- 回傳格式化後的時間字串。
- 可搭配 UIKit / Swift Concurrency 使用。
- 適合整合 Foundation Models Tool Calling。

---

## 📦 安裝方式

如果你是用 Swift Package Manager，將這個套件加入專案後即可使用。

```swift
import WWNtpClientTool
```

---

## 🚀 基本使用

以下範例示範如何在 `UIViewController` 裡查詢美國東部時間。

```swift
import UIKit
import WWNtpClientTool

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task { await getTime(timeZone: "America/New_York") }
    }
}

extension ViewController {
    
    func getTime(timeZone: String) async {
        
        let tool = WWNtpClientTool()
        let arguments = WWNtpClientTool.Arguments(timeZone: timeZone)
        
        do {
            let times = try await tool.call(arguments: arguments)
            print(times.first ?? "No time")
        } catch {
            print("Error reading file: \(error)")
        }
    }
}
```

---

## 📤 回傳結果

`call(arguments:)` 會回傳 `[String]`。

通常第一個元素就是格式化後的時間字串，例如：

```swift
["2026年6月4日 下午4:08:36"]
```

如果查詢失敗，則會回傳錯誤相關資訊。

---

## 🌎 時區範例

你可以傳入以下常見的 IANA 時區識別碼：

- `Asia/Taipei`
- `America/New_York`
- `America/Los_Angeles`
- `America/Chicago`
- `America/Denver`
- `Europe/London`
- `Asia/Tokyo`

---

## 🤖 與 Foundation Models 搭配

這個 Tool 很適合搭配 Foundation Models 的 Tool Calling 使用。

例如當使用者問：

- 「幫我查一下現在在美國的時間是多少？」
- 「紐約現在幾點？」
- 「洛杉磯現在的日期是什麼？」

模型就可以自動呼叫這個 Tool，並傳入對應的 `timeZone`。

---

## 🧩 參數說明

### `Arguments`

```swift
@Generable
public struct Arguments: Sendable {
    public var timeZone: String?
}
```

#### `timeZone`
- 可選的時區字串。
- 建議使用標準 IANA 時區名稱。
- 如果不傳入，預設使用裝置目前時區。
- 如果要查美國時間，建議傳入：
  - `America/New_York`
  - `America/Los_Angeles`
  - `America/Chicago`
  - `America/Denver`

---

## 🕒 時區與顯示格式

這個 Tool 會依照時區將 `Date` 轉成字串顯示。

如果你想顯示中文時間，可以使用：

```swift
formatter.locale = Locale(identifier: "zh_TW")
```

如果使用：

```swift
formatter.locale = .current
```

則會跟著裝置目前語言與地區設定顯示。

---

## ⚠️ 注意事項

- `timeZone` 請使用正確的 IANA identifier。
- `America/New_York` 是美國東部時間。
- `DateFormatter` 建議每次建立新的實例，避免並行安全問題。
- 如果你希望輸出固定為中文，建議不要使用 `.current`，而改用 `Locale(identifier: "zh_TW")`。

