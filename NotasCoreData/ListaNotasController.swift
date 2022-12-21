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
            listaNotas.append(nota)
            print(nota.texto!)
        }
        self.tableView.reloadData()
        
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
        return cell
    }

}
