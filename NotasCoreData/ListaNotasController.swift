//
//  ListaNotasController.swift
//  NotasCoreData
//
//  Created by David López on 16/12/22.
//

import UIKit
import CoreData

class ListaNotasController: UITableViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let texto = searchController.searchBar.text!
        let request: NSFetchRequest<Nota> = Nota.fetchRequest()
        let predicate = NSPredicate(format: "texto contains[c] %@", texto)
        request.predicate = predicate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            listaNotas = try context.fetch(request)
        } catch {
            print("Algo fue mal")
        }
        if listaNotas.isEmpty {
            let request: NSFetchRequest<Nota> = Nota.fetchRequest()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            do {
                listaNotas = try context.fetch(request)
            } catch {
                print("Algo fue mal")
            }
        }
        listaNotas.sort { (Nota1, Nota2) -> Bool in
            guard let fecha1 = Nota1.fecha, let fecha2 = Nota2.fecha else {
                return false
            }
            return fecha1 > fecha2
        }
        tableView.reloadData()
    }
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var listaNotas : [Nota]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listaNotas = []
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar texto"
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
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
