//
//  ScreenSizeReader.swift
//  wheather
//
//  Created by Atirek Pothiwala on 10/02/25.
//

import SwiftUI

struct ScreenSizeReader: View {
    
    @Binding private var screenSize: CGSize
    
    init(_ screenSize: Binding<CGSize>) {
        _screenSize = screenSize
    }
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear.onAppear {
                screenSize = geometry.size
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ScreenSizeReader(Binding.constant(.zero))
}
