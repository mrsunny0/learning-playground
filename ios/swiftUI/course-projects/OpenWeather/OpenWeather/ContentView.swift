import SwiftUI

// 7d777f010144ab86975255e987edd841

struct ContentView: View {
    
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    init() {
        self.weatherViewModel = WeatherViewModel()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            TextField("Enter City Name", text: $weatherViewModel.cityName) {
                self.weatherViewModel.search()
            }.font(.custom("Arial", size: 50))
                .padding()
                .fixedSize()
            
            Text(self.weatherViewModel.temperature)
                .font(.custom("Arial", size: 100))
                .offset(y: 100)
                .foregroundColor(Color.white)
                .padding()
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init(.orange))
            .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
