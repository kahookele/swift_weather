import SwiftUI

struct ContentView: View {
    @StateObject var weatherVM = WeatherViewModel()

    // Animation state for hovering effect
    @State private var isHovering = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Honolulu, HI")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                // Weather icon with hovering animation
                Image(systemName: weatherVM.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                    .offset(y: isHovering ? -10 : 10) // Hover effect
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isHovering)

                Text(weatherVM.temperature)
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)

                Text(weatherVM.description)
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))

                Spacer()
            }
            .padding()
            .onAppear {
                weatherVM.fetchWeather()
                isHovering.toggle() // Start hover animation
            }
        }
    }
}

#Preview {
    ContentView()
}
