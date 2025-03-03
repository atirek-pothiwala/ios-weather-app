//
//  SearchPage.swift
//  wheather
//
//  Created by Atirek Pothiwala on 01/02/25.
//

import SwiftUI
import CoreLocation

struct SearchPage: View {
    
    @StateObject private var viewModel = CityVM()
    @FocusState private var isSearchFieldFocused: Bool
    @State private var selectedCity: CityModel? = nil
    @State private var isNavigateToDetailPage: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if !isSearchFieldFocused {
                    Spacer()
                }
                VStack {
                    SearchField(
                        search: $viewModel.search,
                        isSearchFieldFocused: _isSearchFieldFocused
                    )
                    if !viewModel.filterListCity.isEmpty {
                        ListView()
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.1))
                        .stroke(Color.accentColor, lineWidth: 2)
                }
                Spacer()
            }
            .safeAreaPadding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor)
            .onTapGesture {
                if viewModel.filterListCity.isEmpty {
                    isSearchFieldFocused = false
                }
            }
            .animation(.bouncy, value: isSearchFieldFocused)
            .onAppear {
                viewModel.fetchCities()
            }
            
            NavigationLink(value: isNavigateToDetailPage) {
                EmptyView()
            }.navigationDestination(isPresented: $isNavigateToDetailPage) {
                if let cityModel = selectedCity {
                    DetailPage(
                        model: cityModel,
                        isNavigate: $isNavigateToDetailPage
                    )
                }
            }
        }
    }
    
    private func ListView() -> some View {
        ScrollView(.vertical, content: {
            VStack(spacing: 20) {
                ForEach(viewModel.filterListCity) { item in
                    Text(item.name)
                        .font(Font.callout)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 5)
                        .onTapGesture {
                            selectedCity = item
                            isNavigateToDetailPage = true
                            viewModel.search = ""
                        }
                }
            }
        })
        .scrollIndicators(.never)
        .fixedSize(horizontal: true, vertical: false)
        .frame(
            maxWidth: .infinity,
            maxHeight: CGFloat(viewModel.filterListCity.count * 38).clamped(to: 0...500),
            alignment: .leading
        )
        .padding(.vertical, 20)
        .padding(.horizontal, 25)
    }
}

#Preview {
    SearchPage()
}
