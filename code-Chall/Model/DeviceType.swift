//
//  DeviceType.swift
//  code-Chall
//
//  Created by Hamzah on 10.10.24.
//
enum DeviceType: String, CaseIterable {
    case light = "Licht"
    case thermostat = "Thermostat"
    case lock = "Schloss"
    
    var iconName: String {
        switch self {
        case .light:
            return "lamp.ceiling.fill" // SF Symbol für Licht
        case .thermostat:
            return "thermometer" // SF Symbol für Thermostat
        case .lock:
            return "lock.fill" // SF Symbol für Schloss
        }
    }
}
