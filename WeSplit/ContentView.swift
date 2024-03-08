//
//  ContentView.swift
//  WeSplit
//
//  Created by Álvaro Gascón on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var tipPercentage = 20
    @State private var numberOfPeople = 2
    
    let tipPercentages: Array<Int> = []
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Total", value:$checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
                
                Section("propina (%):") {
                    Picker("Porcentaje de propina", selection: $tipPercentage) {
                        ForEach((2..<100).filter { $0 % 5 == 0 }, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Picker("Número de personas", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0)")
                    }
                }
                
                Section("Total de la cuenta") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                
                Section("Pago por persona") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                
                Section("Pago por pareja") {
                    Text(totalPerPerson * 2, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
