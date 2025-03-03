//
//  SearchView.swift
//  wheather
//
//  Created by Atirek Pothiwala on 10/02/25.
//

import SwiftUI

struct SearchField: View {
    @Binding private var search: String
    @FocusState private var isSearchFieldFocused: Bool
    
    init(search: Binding<String>, isSearchFieldFocused: FocusState<Bool>) {
        _search = search
        _isSearchFieldFocused = isSearchFieldFocused
    }
    
    var body: some View {
        TextField(text: $search) {
            Text("Search City")
                .foregroundStyle(
                    Color.white.opacity(isSearchFieldFocused ? 0.5 : 0.25)
                )
        }
        .keyboardType(.alphabet)
        .padding(.all, 25)
        .foregroundStyle(Color.white)
        .tint(Color.white)
        .background(content: {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.accentColor, lineWidth: 2)
        })
        .focused($isSearchFieldFocused)
        .onChange(of: isSearchFieldFocused) { oldValue, newValue in
            isSearchFieldFocused = newValue
        }
    }
}

#Preview {
    SearchField(
        search: Binding.constant(""),
        isSearchFieldFocused: FocusState.init()
    )
}
