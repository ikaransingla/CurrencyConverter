//
//  CurrencyListView.swift
//  currency-conversion-app
//
//  Created by Karana Singla on 30/10/24.
//

import SwiftUI

struct CurrencyListView: View {
    @StateObject private var viewModel: CurrencyListViewModel

    init(viewModel: CurrencyListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    private var columns: [GridItem] {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth: CGFloat = 100
        let numberOfColumns = Int(screenWidth / itemWidth)
        return Array(repeating: GridItem(.flexible()), count: max(2, numberOfColumns))
    }

    var body: some View {
        VStack(spacing: 16) {
            
            // Picker for target currency selection using fetched currencies
            HStack {
                Text("Convert from:")
                    .font(.headline)
                Picker("Select Currency", selection: $viewModel.selectedCurrency) {
                    ForEach(viewModel.currencies.keys.sorted(), id: \.self) { currencyCode in
                        if let currencyName = viewModel.currencies[currencyCode] {
                            Text("\(currencyCode) - \(currencyName)").tag(currencyCode)
                        }
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Shows as a dropdown menu
            }
            .padding(.horizontal)

            // TextField to enter amount
            HStack {
                Text("Amount to Convert:")
                    .font(.headline)
                TextField("Enter amount", text: Binding(
                    get: { viewModel.amount != nil ? String(viewModel.amount!) : "" },
                    set: { viewModel.amount = Double($0) }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            }
            .padding(.horizontal)


            // Display conversion rates in a dynamic grid
            if viewModel.loading {
                ProgressView("Loading...")
                    .padding()
            } else if let error = viewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.convertedExchangeRates.sorted(by: <), id: \.key) { currency, rate in
                            VStack {
                                Text(currency)
                                    .font(.headline)
                                Text(String(format: "%.2f", rate))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor.secondarySystemBackground)))
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Currency Converter")
        .task {
            await viewModel.loadCurrencyData()
        }
    }
}
