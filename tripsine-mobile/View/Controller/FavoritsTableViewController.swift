//
//  FavoritsTableViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 07/06/22.
//

import UIKit

class FavoritsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritsTableViewCell {
            cell.setupCustomCell()
            return cell
        }
        return UITableViewCell()
    }
}

