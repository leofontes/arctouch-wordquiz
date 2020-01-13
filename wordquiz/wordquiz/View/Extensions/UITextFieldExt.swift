//
//  UITextFieldExt.swift
//  wordQuiz
//
//  Created by Leonardo Thives da Luz Fontes on 1/12/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable extension UITextField {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
