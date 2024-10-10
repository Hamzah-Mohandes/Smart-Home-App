//
//  SmartHome.swift
//  code-Chall
//
//  Created by Hamzah on 10.10.24.
//

import Foundation

struct SmartDevice: Identifiable {
    let id = UUID()
    var name: String
    var type: DeviceType
    var isOn: Bool = false
    var temperature: Double = 20.0 // Standardtemperatur
    var isLocked: Bool = true // Standard: Schloss ist verriegelt

    // Berechnete Eigenschaft für iconName, die auf den Typ zugreift
    var iconName: String {
        return type.iconName
    }
}
