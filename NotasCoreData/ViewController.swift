//
//  ViewController.swift
//  NotasCoreData
//
//  Created by David López on 16/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var labelMensaje: UILabel!
    @IBOutlet weak var txtNota: UITextView!
    
    @IBAction func btnGuardar(_ sender: UIButton) {
    }
    @IBAction func btnCrear(_ sender: UIButton) {
        labelFecha.text = ""
        labelMensaje.text = ""
        txtNota.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

