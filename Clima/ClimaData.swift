import Foundation

struct ClimaData: Codable {
    
    let name: String
    let cod: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
    
}

struct Main: Codable {
    
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    
}

struct Weather: Codable {
    
    let id: Int
    let description: String
    let icon: String
    
}

struct Coord: Codable {
    
    let lat: Double
    let lon: Double
    
}
