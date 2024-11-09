//
//  ContentView.swift
//  UnitConverter
//
//  Created by Naveen on 09/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var conversionValue = 0.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"

    @FocusState private var valueIsFocused: Bool

    let inputUnitSelection = ["Meters", "Feet", "Yards", "Miles", "Kilometers",]
    let outputUnitSelection = ["Meters", "Feet", "Yards", "Miles", "Kilometers",]

    var baseUnitValue: Double {
        var value = 0.0
        switch inputUnit {
        case "Meters":
            value = conversionValue * 1
            return value
        case "Feet":
            value = conversionValue / 3.28084
            return value
        case "Yards":
            value = conversionValue / 3
            return value
        case "Miles":
            value = conversionValue / 5280
            return value
        default:
            value = conversionValue / 1000
            return value
        }
    }

    var convertedValue: Double {
        var value = 0.0
        switch outputUnit {
        case "Meters":
            value = baseUnitValue * 1
            return value
        case "Feet":
            value = baseUnitValue * 3.28084
            return value
        case "Yards":
            value = baseUnitValue * 1.093613
            return value
        case "Miles":
            value = baseUnitValue * 0.0006213712
            return value
        default:
            value = baseUnitValue / 1000
            return value
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value to convert", value: $conversionValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                } header: {
                    Text("Enter Value")
                }

                Section {
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(inputUnitSelection, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Select unit to convert from")
                }

                Section {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(outputUnitSelection, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Select unit to convert to")
                }

                Section {
                    Text(convertedValue.formatted())
                } header: {
                    Text("Converted value")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
