//
//  BackButton.swift
//  wheather
//
//  Created by Atirek Pothiwala on 10/02/25.
//

import SwiftUI

struct BackButton: View {
    @Binding private var isNavigate: Bool
    
    init(isNavigate: Binding<Bool>) {
        _isNavigate = isNavigate
    }
    
    var body: some View {
        Button {
            isNavigate = false
        } label: {
            Image.init(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .padding(.all, 10)
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.white)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.2))
                .strokeBorder(Color.white)
        }
    }
}

#Preview {
    BackButton(isNavigate: Binding.constant(false))
}
