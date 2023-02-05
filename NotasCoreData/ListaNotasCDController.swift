//
//  ListaNotasCDController.swift
//  NotasCoreData
//
//  Created by David López on 5/2/23.
//

import UIKit
import CoreData

class ListaNotasCDController: UITableViewController {
    
    var frc : NSFetchedResultsController<Nota>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let miDelegate = UIApplication.shared.delegate! as! AppDelegate
        let miContexto = miDelegate.persistentContainer.viewContext

        let consulta = NSFetchRequest<Nota>(entityName: "Nota")
        let sortDescriptors = [NSSortDescriptor(key:"fecha", ascending:false)]
        consulta.sortDescriptors = sortDescriptors
        self.frc = NSFetchedResultsController<Nota>(fetchRequest: consulta, managedObjectContext: miContexto, sectionNameKeyPath: nil, cacheName: "miCache")

        //ejecutamos el fetch
        try! self.frc.performFetch()
        //Esto vendría también dentro del viewDidLoad, a continuación de lo anterior
        if let resultados = frc.fetchedObjects {
            print("Hay \(resultados.count) notas")
            for nota in resultados {
                print (nota.texto!)
            }
        }

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.frc.sections!.count
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.frc.sections![section].numberOfObjects
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otraCelda", for: indexPath)
        let nota = self.frc.object(at: indexPath)
        cell.textLabel?.text = nota.texto!
        return cell
    }


}
