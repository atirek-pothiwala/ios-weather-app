//
//  MeasureView.swift
//  wheather
//
//  Created by Atirek Pothiwala on 10/02/25.
//

import SwiftUI
import Lottie

struct MeasureView: View {
    
    let imageName: String
    let value: String
    let padding: Double
    
    init(imageName: String, value: String, padding: Double = 0) {
        self.imageName = imageName
        self.value = value
        self.padding = padding
    }

    var body: some View {
        VStack {
            Image.init(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.white)
                .frame(width: 30 - padding * 2, height: 30 - padding * 2)
                .padding(.all, padding)
            
            Text(value)
                .multilineTextAlignment(.center)
                .font(Font.caption)
                .foregroundStyle(Color.white)
                .padding(.top, 5)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.1))
        }
    }
    
}
