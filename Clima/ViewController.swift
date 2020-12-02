import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var climaManager = ClimaManager()
    var locationManager = CLLocationManager()

    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var sensacionLabel: UILabel!
    @IBOutlet weak var tempminLabel: UILabel!
    @IBOutlet weak var tempmaxLabel: UILabel!
    @IBOutlet weak var climaLabel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temperaturaLabel.text = ""
        ciudadLabel.text = ""
        descripcionLabel.text = ""
        sensacionLabel.text = ""
        tempminLabel.text = ""
        tempmaxLabel.text = ""
        climaLabel.text = ""
        
        
        climaManager.delegado = self
        locationManager.delegate = self
        buscarTextField.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func LocalizacionButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK:- Metodos para actualizar UI
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if !buscarTextField.text!.isEmpty {
            if !buscarTextField.text!.isEmpty {
                climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
            }
            buscarTextField.text = ""
            return true
        }
        else {
            let alertError = UIAlertController(title: "Favor de ingresar una ciudad", message: nil, preferredStyle: .alert)
            let actionErrorAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertError.addAction(actionErrorAceptar)
            self.present(alertError, animated: true, completion: nil)
            return true
        }
        
    }
    
}

//MARK:- Delegados del TextField
extension ViewController: ClimaManagerDelegate {
    
    func huboError(cualError: Error) {
        print(cualError.localizedDescription)
        DispatchQueue.main.async {
            let descripcionError: String
            switch cualError.localizedDescription {
                case "The data couldn’t be read because it is missing.":
                    descripcionError = "No se encontro un resultado"
                case "A server with the specified hostname could not be found.":
                    descripcionError = "Error del servidor"
                default:
                    descripcionError = "Error insepecifico"
            }
            let alertError = UIAlertController(title: descripcionError, message: nil, preferredStyle: .alert)
            let actionErrorAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertError.addAction(actionErrorAceptar)
            self.present(alertError, animated: true, completion: nil)
        }
    }
    
    func actualizarClima(clima: ClimaModelo) {
        print(clima.descripcionClima)
        print(clima.temperatura1Decimal)
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = clima.temperatura1Decimal + "°C"
            self.ciudadLabel.text = clima.nombreCiudad
            self.descripcionLabel.text = clima.descripcionClima.capitalizingFirstLetter()
            self.sensacionLabel.text = "Sensación térmica: " + clima.sensacion1Decimal
            self.tempminLabel.text = "Temp. minima: " + clima.min1Decimal
            self.tempmaxLabel.text = "Temp. maxima: " + clima.max1Decimal
            self.climaImageView.image = UIImage(named: clima.iconoClima)
            self.climaImageView.layer.masksToBounds = true
            self.climaImageView.layer.borderWidth = 2
            self.climaImageView.layer.borderColor = UIColor.systemOrange.cgColor
            self.climaLabel.text = "Clima"
        }
    }
    
}

//MARK:- Protocolo para obtener la ubicacion del usuario
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Se obtuvo la ubicacion")
        if let ubicaciones = locations.last {
            locationManager.stopUpdatingLocation()
            let latitud = ubicaciones.coordinate.latitude
            let longitud = ubicaciones.coordinate.longitude
            print("Lat: \(latitud), Lon: \(longitud)")
            climaManager.fetchClima(latitud: latitud, longitud: longitud)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}


extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
