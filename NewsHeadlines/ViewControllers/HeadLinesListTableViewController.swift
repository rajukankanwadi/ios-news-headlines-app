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
    private let loadingCellId = "loadingViewCell"

    var headlines: HeadlinesInfo?
    var didheadlinesLoad: Bool = false
    var didHeadlinesFailToLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HeadlineTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: headlinesCellId)
        let loadingIndicatorNib = UINib(nibName: "LoadingIndicatorTableViewCell", bundle: nil)
        tableView.register(loadingIndicatorNib, forCellReuseIdentifier: loadingCellId)
        tableView.rowHeight = 220
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "White")

        APIServices.makeGetCall(onSuccess: { [weak self] (headlinesData) in
            self?.headlines = headlinesData
            self?.didheadlinesLoad = true
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }) { (error) in
            self.didHeadlinesFailToLoad = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        if !didheadlinesLoad {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellId, for: indexPath) as! LoadingIndicatorTableViewCell
            cell.failedApiString = "EquipmentFailed"
            cell.refreshButton.isHidden = true
            cell.activityIndicator.startAnimating()

            if didHeadlinesFailToLoad {
                cell.activityIndicator.stopAnimating()
                cell.refreshButton.setTitle("Tap here to refresh News feed", for: .normal)
                cell.refreshButton.isHidden = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: headlinesCellId, for: indexPath) as! HeadlineTableViewCell
            if let article = headlines?.articles?[indexPath.row] {
                cell.article = article
            }
            return cell
        }
    }
}
