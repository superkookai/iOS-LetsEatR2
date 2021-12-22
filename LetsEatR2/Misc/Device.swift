//
//  Device.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 17/12/2564 BE.
//

import UIKit

enum Device{
    static var isPhone: Bool{
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    static var isPad: Bool{
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
