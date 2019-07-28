//
//  HeadLinesListTableViewController.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 26/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import UIKit

class HeadLinesListTableViewController: UITableViewController {

    private let headlinesCellId = "headLinesCell"
    var headlines: HeadlinesInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HeadlineTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: headlinesCellId)
        tableView.rowHeight = 220
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "White")

        APIServices.makeGetCall(onSuccess: { [weak self] (headlinesData) in
            self?.headlines = headlinesData
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }) { (error) in
            print("ERRORRRR")
        }

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines?.articles?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: headlinesCellId, for: indexPath) as! HeadlineTableViewCell
        if let article = headlines?.articles?[indexPath.row] {
            cell.article = article
        }
        return cell
    }
}
