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
    
    var indexRowCount = 0
    
    
    let request:NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: "Player")
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var allPlayers:[Player]?
    var newPlayer:Player!
    var context:NSManagedObjectContext?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.delegate = self
        playersTableView.dataSource = self
//        playersTableView.reloadData()
        
        context = appDelegate?.persistentContainer.viewContext
        allPlayers = try? context?.fetch(request)
        newPlayer = Player(context: context!)
//        print(allPlayers)
        allPlayers?.removeAll()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ident = "cellIdent"
        let cell = tableView.dequeueReusableCell(withIdentifier: ident) as! MyTableViewCell
        if allPlayers?.count == 0 {
            return cell
        }
        cell.textLabel?.text = allPlayers?[0].name ?? ""
        return cell
    }
    
   
    @IBAction func addPlayerPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Change", message: "aaaa", preferredStyle: .alert)
        alertController.addTextField { (textField) -> Void in
                textField.textColor = UIColor.black
            }
        let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        let nextAction: UIAlertAction = UIAlertAction(title: "Add", style: .destructive) { action -> Void in
            let text = alertController.textFields?.first?.text ?? ""
            self.newPlayer.name = text
            self.allPlayers?.append(self.newPlayer)
            self.playersTableView.reloadData()
            print(self.allPlayers![0].name ?? "")
            try? self.self.context?.save()
        }
        alertController.addAction(nextAction)
        alertController.addAction(alertActionTwo)
        indexRowCount += 1
        present(alertController, animated: true, completion: nil)
        print(allPlayers)

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

