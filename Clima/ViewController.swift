import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let climaManager = ClimaManager()

    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscarTextField.delegate = self
    }

    @IBAction func LocalizacionButton(_ sender: UIButton) {
    }
    
    @IBAction func BuscarButton(_ sender: UIButton) {
        if !buscarTextField.text!.isEmpty {
            ciudadLabel.text = buscarTextField.text
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
