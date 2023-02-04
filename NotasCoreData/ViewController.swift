//
//  ViewController.swift
//  NotasCoreData
//
//  Created by David López on 16/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var labelMensaje: UILabel!
    @IBOutlet weak var txtNota: UITextView!
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let miContexto = miDelegate.persistentContainer.viewContext
        let nuevaNota = Nota(context:miContexto)
        nuevaNota.fecha = Date()
        nuevaNota.texto = txtNota.text
        do {
           try miContexto.save()
        } catch {
           print("Error al guardar el contexto: \(error)")
        }


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

