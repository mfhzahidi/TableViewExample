//
//  ViewController.swift
//  TableViewExample
//
//  Created by Macbook Pro on 12/6/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var letter = [["A", "B", "C", "D", "E"], ["F","G", "H", "I", "J"], ["K", "L", "M", "N", "O"], ["P", "Q", "R", "S", "T"], ["U", "V", "W", "X", "Y", "Z"]]
    var images = [["a", "b", "c", "d", "e"], ["f", "g","h", "i", "j"], ["k", "l", "m", "n", "o"], ["p", "q", "r", "s", "t"], ["u", "v", "w", "x", "y", "z"]]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "TableView Example"
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
    
    @IBAction func didTapSort(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return letter.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letter[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text = letter[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.section][indexPath.row])
        return cell*/
        let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        cell.title.text = letter[indexPath.section][indexPath.row]
        cell.letterImage.image = UIImage(named: images[indexPath.section][indexPath.row])
        return cell
    }
    
    //reorder
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let letterToMove = letter[sourceIndexPath.section][sourceIndexPath.row]
        let imageToMove = images[sourceIndexPath.section][sourceIndexPath.row]
        letter[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        images[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        letter[destinationIndexPath.section].insert(letterToMove, at: destinationIndexPath.row)
        images[destinationIndexPath.section].insert(imageToMove, at: destinationIndexPath.row)
    }
    
    //delete
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        letter[indexPath.section].remove(at: indexPath.row)
        images[indexPath.section].remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

