//
//  MenuTableViewController.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/26.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    let menuItems = [
        MenuItem(image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal) ?? UIImage(), title: "Home"),
        MenuItem(image: UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal) ?? UIImage(), title: "Profile"),
        MenuItem(image: UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal) ?? UIImage(), title: "Message"),
        MenuItem(image: UIImage(systemName: "person.3")?.withRenderingMode(.alwaysOriginal) ?? UIImage(), title: "Friends"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.separatorStyle = .none

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseSlideViewController
        slidingController?.didSelectMenuItem(indexPath: indexPath)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = menuItems[indexPath.row].title
        cell.imageView?.image = menuItems[indexPath.row].image
        return cell
    }
    

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = CustomMenuHeaderView()
//        return view
//    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 250
//    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = MenuFooterView()
        view.backgroundColor = .yellow
        return view
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

}
