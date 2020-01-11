//
//  TimeUtil.swift
//  wordQuiz
//
//  Created by Leonardo Fontes on 1/11/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import Foundation

class TimeUtil {
    static let SECONDS_IN_MINUTE = 60
    static let QUIZ_LENGTH_TIME = 300
    
    class func formatCountdownTime(timeInSecs: Int) -> String {
        return "\(StringUtil.formatNumberLeftZero(timeInSecs / SECONDS_IN_MINUTE)):\(StringUtil.formatNumberLeftZero(timeInSecs % SECONDS_IN_MINUTE))"
    }
}
