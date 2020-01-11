//
//  StringUtil.swift
//  wordQuiz
//
//  Created by Leonardo Fontes on 1/11/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import Foundation

class StringUtil {
    class func formatNumberLeftZero(_ num: Int) -> String {
        return num < 10 ? "0\(num)" : "\(num)"
    }
}
