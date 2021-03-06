import Foundation

struct ClimaModelo {
    
    let condicionID: Int
    let nombreCiudad: String
    let descripcionClima: String
    let temperaturaCelcius: Double
    let sensacionClima: Double
    let tempminClima: Double
    let tempmaxClima: Double
    let iconoClima: String
    
    var temperatura1Decimal: String {
        return String(format: "%.1f", temperaturaCelcius)
    }
    
    var sensacion1Decimal: String {
        return String(format: "%.1f", sensacionClima)
    }
    
    var min1Decimal: String {
        return String(format: "%.1f", tempminClima)
    }
    
    var max1Decimal: String {
        return String(format: "%.1f", tempmaxClima)
    }
    
}
