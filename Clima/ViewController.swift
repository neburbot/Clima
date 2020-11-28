import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    
    func huboError(cualError: Error) {
        print(cualError.localizedDescription)
        DispatchQueue.main.async {
            self.ciudadLabel.text = cualError.localizedDescription
        }
    }
    
    func actualizarClima(clima: ClimaModelo) {
        print(clima.descripcionClima)
        print(clima.temperatura1Decimal)
        print(clima.condicionClima)
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = clima.temperatura1Decimal + " °C"
            self.ciudadLabel.text = clima.descripcionClima.capitalizingFirstLetter()
            self.climaImageView.image = UIImage(named: clima.iconoClima)
        }
    }
    
    var climaManager = ClimaManager()

    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        climaManager.delegado = self
        buscarTextField.delegate = self
        
        climaImageView.layer.masksToBounds = true
    }

    @IBAction func LocalizacionButton(_ sender: UIButton) {
    }
    
    @IBAction func BuscarButton(_ sender: UIButton) {
        if !buscarTextField.text!.isEmpty {
            //ciudadLabel.text = buscarTextField.text
            climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
        }
        else {
            buscarTextField.placeholder = "Escribe una ciudad"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //ciudadLabel.text = buscarTextField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if !buscarTextField.text!.isEmpty {
            ciudadLabel.text = buscarTextField.text
            return true
        }
        else {
            buscarTextField.text = "Escribe una ciudad"
            return false
        }
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
