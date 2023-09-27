//
//  ContentView.swift
//  WeSplit
//
//  Created by Aaron Brown on 9/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPayees: Int = 2
    @State private var tipPerentage: Int = 20
    @FocusState private var amountIsFocued: Bool
    
    
    let tipPerentages: Array = [10, 15, 20, 25, 0]
    let numOfPeople: [Int] = [2, 3, 4, 5, 6, 7, 8, 10]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPayees)
        let tipSelection = Double(tipPerentage)
        let tipValue = ((checkAmount / 100) * tipSelection)
        let grandTotal = checkAmount + tipValue
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section{
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocued)
                    Picker("Number of Payees", selection: $numberOfPayees) {
                        ForEach(numOfPeople, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPerentage) {
                        ForEach(tipPerentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocued = false
                    }
                }
            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
