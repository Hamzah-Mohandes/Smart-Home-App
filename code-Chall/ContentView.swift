import SwiftUI

struct ContentView: View {
    // Initialisiere ein Array von SmartDevice-Objekten
    @State private var devices: [SmartDevice] = [
        SmartDevice(name: "Wohnzimmerlicht", type: .light),
        SmartDevice(name: "Heizung", type: .thermostat),
        SmartDevice(name: "Haustür", type: .lock)
    ]

    // Variablen für die Benutzereingaben
    @State private var newDeviceName: String = ""
    @State private var selectedDeviceType: DeviceType = .light
    @State private var showRoomView: Bool = false // Toggle-Zustand für die RoomView

    var body: some View {
        VStack {
            // Header
            Text("Smart Home Geräte")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.top)

            // Horizontaler Stack für das Textfeld und den Picker
            HStack {
                // Textfeld für den Gerätenamen
                TextField("Gerätename eingeben", text: $newDeviceName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)

                // Picker für den Gerätetyp
                Picker("Gerätetyp wählen", selection: $selectedDeviceType) {
                    ForEach(DeviceType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            }
            .padding(.horizontal)

            // Button zum Hinzufügen eines neuen Geräts
            Button(action: {
                // Neues Gerät hinzufügen
                let newDevice = SmartDevice(name: newDeviceName, type: selectedDeviceType)
                devices.append(newDevice)

                // Textfeld zurücksetzen
                newDeviceName = ""
            }) {
                Text("Hinzufügen")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity) // Button über die gesamte Breite
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.green, Color.green.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)

            // Scrollbare Liste der Geräte
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach($devices) { $device in
                        HStack {
                            SmartDeviceView(device: $device)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)

                            Button(action: {
                                // Gerät löschen
                                if let index = devices.firstIndex(where: { $0.id == device.id }) {
                                    devices.remove(at: index)
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Button-Stil anpassen, um den HStack nicht zu stören
                        }
                        .padding(.vertical, 5) // Abstand zwischen den Geräten
                    }
                }
                .padding()
            }

            Spacer()

            // Toggle für die Anzeige der RoomView
            Toggle("Raumvorschau anzeigen", isOn: $showRoomView)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)

            // RoomView anzeigen, wenn der Toggle aktiviert ist
            if showRoomView {
                RoomView(devices: devices)
                    .padding()
                    .background(Color.orange.opacity(0.3))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.bottom) // Abstand nach unten
            }
        }
        .background(Color(UIColor.systemGroupedBackground)) // Hintergrundfarbe der gesamten Ansicht
        .cornerRadius(15)
    }
}

#Preview {
    ContentView()
}
