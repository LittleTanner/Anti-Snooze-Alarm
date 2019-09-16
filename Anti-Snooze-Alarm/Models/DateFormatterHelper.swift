//
//  DateFormatterHelper.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/16/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

extension Date {
    func stringWith(timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}
