import SwiftUI

struct RoomView: View {
    // Devices-Variable, die die SmartHome-Geräte speichert
    var devices: [SmartDevice]

    var body: some View {
        VStack(spacing: 20) {
            // Bereich für Lampen
            HStack {
                ForEach(devices) { device in
                    if device.type == .light {
                        VStack {
                            Image(systemName: "lamp.ceiling.fill")
                                .imageScale(.large)
                                .foregroundStyle(device.isOn ? .yellow : .black)
                            Text(device.name)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding()
            .background(Color.orange.opacity(0.3))
            .cornerRadius(10)

            // Bereich für Thermostate
            HStack {
                ForEach(devices) { device in
                    if device.type == .thermostat {
                        VStack {
                            Image(systemName: "thermometer")
                                .imageScale(.large)
                                .foregroundStyle(.blue)
                            Text(device.name)
                                .font(.caption)

                            // Temperatur anzeigen
                            Text("\(device.temperature, specifier: "%.1f") °C") // Temperaturformatierung
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(10)

            // Bereich für Türen
            HStack {
                ForEach(devices) { device in
                    if device.type == .lock {
                        VStack {
                            Image(systemName: device.isLocked ? "lock.fill" : "lock.open.fill")
                                .imageScale(.large)
                                .foregroundStyle(device.isLocked ? .red : .green)
                            Text(device.name)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding()
            .background(Color.blue.opacity(0.3))
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    RoomView(devices: [
        SmartDevice(name: "Lampe1", type: .light),
        SmartDevice(name: "Lampe2", type: .light, isOn: true),
        SmartDevice(name: "Tür1", type: .lock),
        SmartDevice(name: "Tür2", type: .lock),
        SmartDevice(name: "Tür3", type: .lock, isLocked: false),
        SmartDevice(name: "Thermo1", type: .thermostat, temperature: 22.5) // Beispieltemperatur
    ])
}
