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
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var allPlayers:[Player]?
    var newPlayer:Player!
    var context:NSManagedObjectContext?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.delegate = self
        playersTableView.dataSource = self
        context = appDelegate?.persistentContainer.viewContext
        allPlayers = try? context?.fetch(request)
        newPlayer = Player(context: context!)
//        allPlayers?.removeAll()
        // Do any additional setup after loading the view.
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        playersTableView.reloadData()6yd
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        context = appDelegate?.persistentContainer.viewContext
//        allPlayers = try? context?.fetch(request)
//        newPlayer = Player(context: context!)
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
            for i in self.allPlayers! {
                if i.name == cell.textLabel?.text {
                    i.name = text
                }
            }
            self.playersTableView.reloadData()
        }
        alertController.addAction(nextAction)
        alertController.addAction(alertActionTwo)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "delate") { [self] (action, view, handler) in
//            context = self.appDelegate?.persistentContainer.viewContext
//            self.allPlayers = try? context?.fetch(request)
//            newPlayer = Player(context: context!)
            self.allPlayers?.remove(at: indexPath.row)
            self.playersTableView.reloadData()
            try? self.context?.save()
//            print(allPlayers?.count)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
//    var alertController:UIAlertController!
    
    @IBAction func addPlayerPressed(_ sender: UIButton) {
        context = appDelegate?.persistentContainer.viewContext
        allPlayers = try? context?.fetch(request)
        newPlayer = Player(context: context!)
        let alertController = UIAlertController(title: "Change", message: "aaaa", preferredStyle: .alert)
        alertController.addTextField { (textField) -> Void in
                textField.textColor = UIColor.black
            }
        let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .default) { action -> Void in
            let text = alertController.textFields?.first?.text ?? ""
            if alertController.textFields?.first?.text == "" {
                alertController.title = "greq tmi anuny"
                return
            }
            self.newPlayer.name = text
            self.allPlayers?.append(self.newPlayer)
            self.playersTableView.reloadData()
            try? self.context?.save()
        }
        alertController.addAction(nextAction)
        alertController.addAction(alertActionTwo)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
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

