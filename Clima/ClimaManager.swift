import Foundation

protocol ClimaManagerDelegate {
    func actualizarClima(clima: ClimaModelo)
}

struct ClimaManager {
    
    var delegado: ClimaManagerDelegate?
    
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=ad1b26cb01822a183f35550fd50c8b5b&units=metric&lang=es"
    
    func fetchClima(nombreCiudad: String) {
        let urlString = "\(climaURL)&q=\(nombreCiudad)"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            //let tarea = session.dataTask(with: url, completionHandler: handle(data: respuesta: error:)
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil {
                    print(error!)
                }
                if let datosSeguros = data {
                    //let dataString = String(data: datosSeguros, encoding: .utf8)
                    //print(dataString!)
                    //self.parseJSON(climaData: datosSeguros)
                    if let clima = self.parseJSON(climaData: datosSeguros) {
                        self.delegado?.actualizarClima(clima: clima)
                    }
                }
            }
            tarea.resume()
        }
    }
    
    /*func handle(data: Data?, respuesta: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
        }
        if let datosSeguros = data {
            let dataString = String(data: datosSeguros, encoding: .utf8)
            print(dataString!)
        }
    }*/
    
    func parseJSON(climaData: Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        do {
            let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            /*print(dataDecodificada.name)
            print(dataDecodificada.cod)
            print(dataDecodificada.main.temp)
            print(dataDecodificada.main.humidity)
            print(dataDecodificada.weather[0].description)
            print("Latitud: \(dataDecodificada.coord.lat), longitud: \(dataDecodificada.coord.lon)")*/
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            let temperatura = dataDecodificada.main.temp
            
            let ObjClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, descripcionClima: descripcion, temperaturaCelcius: temperatura)
            return ObjClima
        }
        catch {
            print(error)
            return nil
        }
    }
    
}
