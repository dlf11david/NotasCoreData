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
    
    @IBAction func btnNuevaLibreta(_ sender: UIButton) {
        nuevaLibreta()
    }
    
    
    func nuevaLibreta() {
        let alert = UIAlertController(title: "Nueva libreta",
                                      message: "Escribe el nombre para la nueva libreta",
                                      preferredStyle: .alert)
        let crear = UIAlertAction(title: "Crear", style: .default) {
            action in
            let nombre = alert.textFields![0].text!
            guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let miContexto = miDelegate.persistentContainer.viewContext
            let nuevaLibreta = Libreta(context:miContexto)
            nuevaLibreta.nombre = nombre
            do {
               try miContexto.save()
            } catch {
               print("Error al guardar el contexto: \(error)")
            }
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel) {
            action in
        }
        alert.addAction(crear)
        alert.addAction(cancelar)
        alert.addTextField() { $0.placeholder = "Nombre"}
        self.present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

