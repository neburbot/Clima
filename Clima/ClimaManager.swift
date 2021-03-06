import Foundation

protocol ClimaManagerDelegate {
    
    func actualizarClima(clima: ClimaModelo)
    func huboError(cualError: Error)
    
}

struct ClimaManager {
    
    var delegado: ClimaManagerDelegate?
    
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=ad1b26cb01822a183f35550fd50c8b5b&units=metric&lang=es"
    
    func fetchClima(nombreCiudad: String) {
        let auxCiudad = nombreCiudad.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let urlString = "\(climaURL)&q=\(auxCiudad)"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func fetchClima(latitud: Double, longitud: Double) {
        let urlString = "\(climaURL)&lat=\(latitud)&lon=\(longitud)"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil {
                    self.delegado?.huboError(cualError: error!)
                }
                else {
                    if let datosSeguros = data {
                        if let clima = self.parseJSON(climaData: datosSeguros) {
                            self.delegado?.actualizarClima(clima: clima)
                        }
                    }
                }
            }
            tarea.resume()
        }
    }
    
    func parseJSON(climaData: Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        do {
            let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            let temperatura = dataDecodificada.main.temp
            let sensacion = dataDecodificada.main.feels_like
            let min = dataDecodificada.main.temp_min
            let max = dataDecodificada.main.temp_max
            let icono = dataDecodificada.weather[0].icon
            
            let ObjClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, descripcionClima: descripcion, temperaturaCelcius: temperatura, sensacionClima: sensacion, tempminClima: min, tempmaxClima: max, iconoClima: icono)
            return ObjClima
        }
        catch {
            self.delegado?.huboError(cualError: error)
            return nil
        }
    }
    
}
