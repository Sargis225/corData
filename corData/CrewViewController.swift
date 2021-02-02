//
//  CrewViewController.swift
//  corData
//
//  Created by Saq on 2/1/21.
//

import UIKit
import CoreData

class CrewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var crewTableView: UITableView!
    
    var context:NSManagedObjectContext!
    var crew:[Crew] = []
    var set:NSSet!
    let request:NSFetchRequest<Crew> = NSFetchRequest<Crew>(entityName: "Crew")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crewTableView.delegate = self
        crewTableView.dataSource = self
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            self.context = context
            crew = try! self.context.fetch(request)
            for i in 0...crew.count - 1 {
                print(crew[i].score)
                
            }
        } else {
            fatalError("can not create context")
        }
//        print(crew[0].playersSet)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crew.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ident = "crewCellIdent"
        let cell = tableView.dequeueReusableCell(withIdentifier: ident) as! CrewTableViewCell
        cell.textLabel?.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = crew[indexPath.row].teamName ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
