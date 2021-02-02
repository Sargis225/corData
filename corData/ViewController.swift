//
//  ViewController.swift
//  corData
//
//  Created by Saq on 1/29/21.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var playersTableView: UITableView!
    
//    var indexRowCount = 0
    
    
    let request:NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    var allPlayers:[Player]?
    var context:NSManagedObjectContext!
    var selectedPlayers:[Player] = []
//    var newCrew:Crew!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.delegate = self
        playersTableView.dataSource = self
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            self.context = context
            allPlayers = try? context.fetch(request)
        } else {
            fatalError("can not create context")
        }
        playersTableView.allowsMultipleSelection = true
        playersTableView.allowsMultipleSelectionDuringEditing = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlayers?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ident = "cellIdent"
        let cell = tableView.dequeueReusableCell(withIdentifier: ident) as! MyTableViewCell
        cell.textLabel?.text = allPlayers?[indexPath.row].name ?? ""
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlayers.append(allPlayers![indexPath.row])
//        print(selectedPlayers)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedPlayers.remove(at: indexPath.row)
//        print(selectedPlayers)

    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "delate") { [self] (action, view, handler) in
            guard let player = self.allPlayers?.remove(at: indexPath.row) else { return }
            self.playersTableView.reloadData()
            self.context?.delete(player)
            try? self.context?.save()
        }
        let renameAction = UIContextualAction(style: .normal, title: "remove") { (action, view, handler) in
            let alertController = UIAlertController(title: "Change", message: "aaaa", preferredStyle: .alert)
            alertController.addTextField { (textField) -> Void in
                textField.textColor = UIColor.black
            }
            let cell = tableView.cellForRow(at: indexPath) as! MyTableViewCell
            alertController.textFields?.first?.text = cell.textLabel?.text ?? ""
            let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                
            }
            let nextAction: UIAlertAction = UIAlertAction(title: "Change", style: .default) { action -> Void in
                let text = alertController.textFields?.first?.text ?? ""
                
                self.allPlayers![indexPath.row].name = text
                try? self.context.save()
                self.playersTableView.reloadData()
            }
            alertController.addAction(nextAction)
            alertController.addAction(alertActionTwo)
            self.present(alertController, animated: true, completion: nil)
        }
        return UISwipeActionsConfiguration(actions: [action, renameAction])
    }
    
    
    @IBAction func addPlayerPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add new player", message: "Write name", preferredStyle: .alert)
        alertController.addTextField { (textField) -> Void in
                textField.textColor = UIColor.black
            }
        let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .default) { action -> Void in
            guard let text = alertController.textFields?.first?.text, text != "" else { return }
            let newPlayer = Player(context: self.context)
            newPlayer.name = text
            self.allPlayers?.append(newPlayer)
            self.playersTableView.reloadData()
            try? self.context?.save()
        }
        alertController.addAction(nextAction)
        alertController.addAction(alertActionTwo)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func addCrewPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Write the name of the team", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) -> Void in
                textField.textColor = UIColor.black
            }
        let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        let nextAction: UIAlertAction = UIAlertAction(title: "AddNewTeam", style: .default) { action -> Void in
            guard let text = alertController.textFields?.first?.text, text != "" else { return }
            let newCrew = Crew(context: self.context)
            newCrew.teamName = ""
            guard self.selectedPlayers.count > 0 else { return }
            for i in self.selectedPlayers {
                newCrew.playersSet?.adding(i)
            }
            for i in self.selectedPlayers {
//                newCrew.playersSet?.adding(i)
                newCrew.addToPlayersSet(i)
                newCrew.teamName = text
            }
            try? self.context.save()
            self.playersTableView.reloadData()
            print(newCrew.playersSet)
        }
        alertController.addAction(nextAction)
        alertController.addAction(alertActionTwo)
        present(alertController, animated: true, completion: nil)
        
    }
//    var set:NSSet!
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if let vc = segue.destination as? CrewViewController {
////            vc.crew = newCrew
////            vc.context = context
////            vc.set = set
////        }
//    }
//
    
    
    
    
    
    
    
    
    
    
//    @IBAction func renamePlayer(_ sender: UIButton) {
//        let request:NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let context = appDelegate?.persistentContainer.viewContext
//        let allPlayers = try? context?.fetch(request)
//        print(allPlayers!)
////        for i in allPlayers! {
////            i.name = playerNameTextField.text ?? ""
////            i.score = Int16(scoreTextField.text ?? "") ?? 0
////            print(i.name ?? "")
////            print(i.score)
////            i.score += 1
////        }
//       try?  context?.save()
//
//    }
//
//
//    @IBAction func delatePlayerPressed(_ sender: UIButton) {
//        let request:NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let context = appDelegate?.persistentContainer.viewContext
//        var allPlayers = try? context?.fetch(request)
//        allPlayers?.removeAll()
////        for i in allPlayers! {
////            if  i.name == ""  {
////                context?.delete(i)
////            }
////        }
//        try? context?.save()
//
//    }
    
    
    
    
}

