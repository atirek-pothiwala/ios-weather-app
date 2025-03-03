//
//  DetailPage.swift
//  wheather
//
//  Created by Atirek Pothiwala on 02/02/25.
//

import SwiftUI
import MapKit
import Lottie

struct DetailPage: View {
    
    private var model: CityModel
    @Binding private var isNavigate: Bool
    
    init(model: CityModel, isNavigate: Binding<Bool>) {
        self.model = model
        _isNavigate = isNavigate
    }
    
    @StateObject private var viewModel = WeatherVM()
    @State private var screenSize: CGSize = .zero
    private var imageSize: CGFloat {
        return screenSize.width * 0.2
    }
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            WindmillView()
            HeaderView()
            ScreenSizeReader($screenSize)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbarVisibility(.hidden, for: .automatic)
        .safeAreaPadding(.all)
        .background(Color.accentColor)
        .onAppear {
            isAnimating = true
            viewModel.fetchWeather(model.location)
        }
    }
    
    private func HeaderView() -> some View {
        VStack(alignment: .leading) {
            BackButton(isNavigate: $isNavigate)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(model.name)
                        .font(Font.title)
                        .foregroundStyle(Color.white)
                    
                    Rectangle()
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: screenSize.width * 0.35, maxHeight: 1)
                    
                    if let title = viewModel.weatherTitle,
                       let image = viewModel.weatherImage {
                     
                        Text(title)
                            .font(Font.title3)
                            .foregroundStyle(Color.white)
                            .padding(.top, 10)
                        
                        Image(systemName: image)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.white)
                            .frame(width: imageSize, height: imageSize)
                            .padding(.top, 10)
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .scaledToFit()
                            .frame(width: imageSize, height: imageSize)
                    }
                }
                .animation(.easeInOut, value: isAnimating)
                
                Spacer()
                
                if let windSpeed = viewModel.windSpeed {
                    MeasureView(imageName: "wind", value: windSpeed)
                }
                if let windDirection = viewModel.windDirection {
                    MeasureView(imageName: "location.fill", value: windDirection, padding: 5)
                }
                if let temperature = viewModel.temperature {
                    MeasureView(imageName: "thermometer", value: temperature)
                }
            }
            .padding(.top, 25)
            
            Spacer()
            
            HStack {
                MapView()
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaPadding()
    }
    
    private func WindmillView() -> some View {
        ZStack {
            LottieView(animation: .named("windmill.json"))
                .looping()
                .scaleEffect(1.7)
                .offset(x: screenSize.width * 0.5, y: screenSize.height * 0.21)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    private func MapView() -> some View {
        Map(initialPosition: MapCameraPosition.region(model.location.toRegion()))
            .mapStyle(.hybrid)
            .frame(width: screenSize.width * 0.5, height: screenSize.width * 0.5)
            .cornerRadius(20)
            .animation(.easeInOut, value: isAnimating)
    }
}

#Preview {
    DetailPage(
        model: CityModel(
            name: "Vadodara",
            location: Location(
                latitude: 22.3220194,
                longitude: 73.0082718
            )
        ),
        isNavigate: Binding.constant(false)
    )
}
