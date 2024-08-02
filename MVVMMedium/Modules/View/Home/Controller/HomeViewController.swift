//
//  HomeViewController.swift
//  MVVMMedium
//
//  Created by Ganpat Jangir on 01/08/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let vm = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        
    }
}
