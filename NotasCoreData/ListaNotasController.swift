//
//  ListaNotasController.swift
//  NotasCoreData
//
//  Created by David López on 16/12/22.
//

import UIKit
import CoreData

class ListaNotasController: UITableViewController {
    
    var listaNotas : [Nota]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hola soy ListaNotasController")

    }

    override func viewWillAppear(_ animated: Bool) {

        let request = Nota.fetchRequest()
        guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let miContexto = miDelegate.persistentContainer.viewContext
        listaNotas = try! miContexto.fetch(request)
        for nota in listaNotas {
            print(nota.texto!)
        }
        self.tableView.reloadData()
        
        //Provisional
        
        let queryLibretas = NSFetchRequest<Libreta>(entityName:"Libreta")
        let libretas = try! miContexto.fetch(queryLibretas)
        for libreta in libretas {
            print(libreta.nombre)
        }
        //Provisional
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaNotas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)
        cell.textLabel?.text = self.listaNotas[indexPath.row].texto
        cell.detailTextLabel?.text = self.listaNotas[indexPath.row].libreta?.nombre
        return cell
    }

}
