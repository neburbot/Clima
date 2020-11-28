import Foundation

struct ClimaData: Decodable {
    
    let name: String
    let cod: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
    
}

struct Main:Decodable {
    
    let temp: Double
    let humidity: Int
    
}

struct Weather: Decodable {
    
    let description: String
    
}

struct Coord: Decodable {
    
    let lat: Double
    let lon: Double
    
}
