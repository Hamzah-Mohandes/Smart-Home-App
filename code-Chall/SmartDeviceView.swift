import SwiftUI

struct SmartDeviceView: View {
    @Binding var device: SmartDevice

    var body: some View {
        HStack {
            // Anzeige des Gerätsymbols
            Image(systemName: device.iconName) // Zugriff auf die iconName-Eigenschaft
                .imageScale(.large)
                .foregroundStyle(device.isOn ? .yellow : .black) // Gelb, wenn das Licht an ist
            
            // Anzeige von Name und Typ
            VStack(alignment: .leading) {
                Text(device.name)
                    .font(.headline)
                Text(device.type.rawValue)
                    .font(.subheadline)
            }
            .padding(.leading)

            Spacer()

            // Steuerungselemente je nach Gerätetyp
            switch device.type {
            case .light:
                Toggle(isOn: $device.isOn) {
                    Text(device.isOn ? "An" : "Aus")
                }
                .toggleStyle(SwitchToggleStyle())

            case .thermostat:
                Slider(value: $device.temperature, in: 15...30, step: 0.5) {
                    Text("Temperatur: \(device.temperature, specifier: "%.1f") °C")
                }

            case .lock:
                Button(action: {
                    device.isLocked.toggle() // Sperrstatus umschalten
                }) {
                    Text(device.isLocked ? "Entsperren" : "Sperren")
                        .padding()
                        .background(device.isLocked ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.bottom, 10)
    }
}

#Preview {
    SmartDeviceView(device: .constant(
        SmartDevice(name: "Wohnzimmerlicht", type: .light)
    ))
}
