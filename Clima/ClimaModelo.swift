import Foundation

struct ClimaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let descripcionClima: String
    let temperaturaCelcius: Double
    let iconoClima: String
    
    var condicionClima: String {
        switch condicionID {
            case 200...232:
                return "cloud.bolt"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.min"
            default:
                return "cloud"
        }
    }
    
    var temperatura1Decimal: String {
        return String(format: "%.1f", temperaturaCelcius)
    }
    
}
