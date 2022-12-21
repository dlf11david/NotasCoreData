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
        let notas = try! miContexto.fetch(request)
        for nota in notas {
           print(nota.texto!)
        }

        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
