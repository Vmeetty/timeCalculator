//
//  TimeModel.swift
//  Chron
//
//  Created by vlad on 09.05.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation

class TimeModel {
    
    var seconds = 0
    
    init(inSeconds: Int) {
        seconds = inSeconds
    }
    convenience init(hours: Int, minutes: Int, seconds: Int) {
        self.init(inSeconds: seconds + minutes * 60 + hours * 3600)
    }
    func toSeconds (hours: Int, minutes: Int, seconds: Int) -> Int {
        return seconds + minutes * 60 + hours * 3600
    }
    
    func title() -> String {
        // Convert to "00:00:00" string
        let hour = seconds / 3600
        let sec = seconds - (hour * 3600)
        let min = sec / 60
        let second = sec - (min * 60)

        return "\(hour):\(min):\(second)"
    }
    
    static func calculateOverallSeconds (times: [TimeModel]) -> TimeModel {
        var overAllSeconds = 0
        for time in times {
            overAllSeconds += time.seconds
        }
        return TimeModel(inSeconds: overAllSeconds)
    }
    
    static func updateResult (seconds: TimeModel) -> String {
        let overAllTime = seconds.title()
        return overAllTime
    }
}







