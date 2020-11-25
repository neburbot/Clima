//
//  ViewController.swift
//  Clima
//
//  Created by Mac19 on 24/11/20.
//  Copyright © 2020 ITM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LocalizacionButton(_ sender: UIButton) {
    }
    
    @IBAction func BuscarButton(_ sender: UIButton) {
    }
    
}

