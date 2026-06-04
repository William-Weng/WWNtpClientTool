//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/6/4.
//

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
