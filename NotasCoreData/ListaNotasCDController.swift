//
//  ListaNotasCDController.swift
//  NotasCoreData
//
//  Created by David López on 5/2/23.
//

import UIKit
import CoreData


class ListaNotasCDController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var frc : NSFetchedResultsController<Nota>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let miDelegate = UIApplication.shared.delegate! as! AppDelegate
        let miContexto = miDelegate.persistentContainer.viewContext

        let consulta = NSFetchRequest<Nota>(entityName: "Nota")
        let sortDescriptors = [NSSortDescriptor(key:"contenido", ascending:false)]
        consulta.sortDescriptors = sortDescriptors
        self.frc = NSFetchedResultsController<Nota>(fetchRequest: consulta, managedObjectContext: miContexto, sectionNameKeyPath: "inicial", cacheName: "miCache")

        self.frc.delegate = self
        try! self.frc.performFetch()
        if let resultados = frc.fetchedObjects {
            print("Hay \(resultados.count) notas")
            for nota in resultados {
                print (nota.contenido!)
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
        cell.textLabel?.text = nota.contenido!
        return cell
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with:.automatic )
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
            self.tableView.insertRows(at: [newIndexPath!], with:.automatic )
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch(type) {
        case .insert:
            self.tableView.insertSections(IndexSet(integer:sectionIndex), with: .automatic)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer:sectionIndex), with: .automatic)
        default: break
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let miDelegate = UIApplication.shared.delegate as! AppDelegate
                let miContexto = miDelegate.persistentContainer.viewContext
                let objectToDelete = self.frc.object(at: indexPath)
                miContexto.delete(objectToDelete)
                try! miContexto.save()
            }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return self.frc.sections?[section].name
    }




}
