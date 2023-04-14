//
//  Constants.swift
//  FlingoLingo
//
//  Created by Yandex on 12.04.2023.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: screen sizes
    let screenWidth: Double
    let screenHeight: Double
    
    // MARK: check if we faced with "max" iphone
    var isBigDevice: Bool
    
    // MARK: some fonts sizes
    var largeFontSize: Double
    var smallFontSize: Double
    
    // MARK: some paddings
    var topPadding: Double
    var leadingAnchor: Double
    
    init() {
        
        self.screenWidth = UIScreen.main.bounds.width
        self.screenHeight = UIScreen.main.bounds.height
        self.isBigDevice = screenHeight > 900 ? true : false
        self.largeFontSize = isBigDevice ? 32 : 30
        self.smallFontSize = isBigDevice ? 15 : 13
        self.topPadding = screenHeight * 0.09
        self.leadingAnchor = screenWidth * 0.06
        
    }
    
}
