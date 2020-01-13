//
//  UIButtonExt.swift
//  wordQuiz
//
//  Created by Leonardo Thives da Luz Fontes on 1/10/20.
//  Copyright © 2020 Leo Fontes. All rights reserved.
//

import Foundation
import UIKit

//From: https://stackoverflow.com/a/45089222/3473971
@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
