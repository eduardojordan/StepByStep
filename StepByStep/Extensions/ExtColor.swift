//
//  ExtColor.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 21/4/21.
//

import UIKit

extension UIColor {
    
    public convenience init?(hexString: String) {
        let red, green, blue, alpha: CGFloat

        var newHexString = hexString
        if (hexString.count == 7) {
            newHexString += "FF"
        }

        if newHexString.hasPrefix("#") {
            let start = newHexString.index(newHexString.startIndex, offsetBy: 1)
            let hexColor = String(newHexString.suffix(from: start))

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
    
}
