# [WWNtpClientTool](https://swiftpackageindex.com/William-Weng)

[![Swift-6.2](https://img.shields.io/badge/Swift-6.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![iOS-26.0](https://img.shields.io/badge/iOS-26.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWNtpClientTool)
[![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

[English](./README.en.md) | [繁體中文](./README.md)

---

`WWNtpClientTool` is a tool for querying **NTP network time**.

It can return the current time string for a specified timezone, making it useful for:
- Showing local time
- Checking time in other countries or cities
- Using with Foundation Models tool calling
- Letting AI decide which timezone to query based on user intent

---

## ✨ Features

- NTP time querying support.
- Supports IANA timezone identifiers such as `Asia/Taipei` and `America/New_York`.
- Returns a formatted time string.
- Works well with UIKit and Swift Concurrency.
- Designed for Foundation Models tool calling.

---

## 📦 Installation

If you are using Swift Package Manager, add this package to your project and import it.

```swift
import WWNtpClientTool
```

---

## 🚀 Basic Usage

The following example shows how to query Eastern Time in a `UIViewController`.

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

## 📤 Return Value

`call(arguments:)` returns `[String]`.

The first element is usually the formatted time string, for example:

```swift
["June 4, 2026 at 4:08:36 PM"]
```

If the query fails, the returned string may contain an error description.

---

## 🌎 Timezone Examples

You can pass common IANA timezone identifiers such as:

- `Asia/Taipei`
- `America/New_York`
- `America/Los_Angeles`
- `America/Chicago`
- `America/Denver`
- `Europe/London`
- `Asia/Tokyo`

---

## 🤖 Using with Foundation Models

This tool is a good fit for Foundation Models tool calling.

For example, when the user asks:

- “What time is it in the US?”
- “What time is it in New York?”
- “What is the current date in Los Angeles?”

the model can automatically call this tool and pass the appropriate `timeZone`.

---

## 🧩 Arguments

### `Arguments`

```swift
@Generable
public struct Arguments: Sendable {
    public var timeZone: String?
}
```

#### `timeZone`
- Optional timezone string.
- Use a standard IANA timezone identifier.
- If omitted, the device’s current timezone will be used.
- For US time, you may want to pass:
  - `America/New_York`
  - `America/Los_Angeles`
  - `America/Chicago`
  - `America/Denver`

---

## 🕒 Timezone and Formatting

This tool converts `Date` into a formatted string according to the target timezone.

If you want Chinese output, you can use:

```swift
formatter.locale = Locale(identifier: "zh_TW")
```

If you use:

```swift
formatter.locale = .current
```

the output will follow the device’s current language and region settings.

---

## ⚠️ Notes

- Make sure `timeZone` uses a valid IANA identifier.
- `America/New_York` is Eastern Time in the United States.
- It is recommended to create a new `DateFormatter` instance each time to avoid concurrency issues.
- If you want fixed Chinese output, prefer `Locale(identifier: "zh_TW")` instead of `.current`.

