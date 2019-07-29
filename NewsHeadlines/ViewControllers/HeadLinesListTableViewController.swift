//
//  HeadLinesListTableViewController.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 26/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

let newsStoryboard = "News"
class HeadLinesListTableViewController: BaseTableViewController {

    static let storyBoardId = "HeadLinesTVC"
    private let headlinesCellId = "headLinesCell"
    private let loadingCellId = "loadingViewCell"

    var headlines: HeadlinesInfo?
    var didheadlinesLoad: Bool = false
    var didHeadlinesFailToLoad: Bool = false

    var headlinesToken: NotificationToken?
    var headlinesPayload: Results<HeadlinesInfo>?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HeadlineTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: headlinesCellId)
        let loadingIndicatorNib = UINib(nibName: "LoadingIndicatorTableViewCell", bundle: nil)
        tableView.register(loadingIndicatorNib, forCellReuseIdentifier: loadingCellId)
        tableView.rowHeight = 220
    }

    private func fetchHeadlines() {
        APIServices.shared.getTopHeadlinesCall { (error) in
            self.didHeadlinesFailToLoad = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func subscribeToLookUpAccountChanges() {
        guard let realm = lazyRealm else {
            return
        }

        headlinesPayload = realm.objects(HeadlinesInfo.self)
        headlinesToken = headlinesPayload?.observe({ [weak self] (changes) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                guard let headlinesPayload = self.headlinesPayload, headlinesPayload.count > 0 else {
                    return
                }
                print(headlinesPayload.first?.status ?? "nilll")
            case .update:
                guard let headlinesPayload = self.headlinesPayload, headlinesPayload.count > 0 else {
                    return
                }
                self.headlines = headlinesPayload.first
//                guard let articles = headlinesPayload.first?.articles else {return}
                self.didheadlinesLoad = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        })
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "White")
        //API call
        subscribeToLookUpAccountChanges()
        fetchHeadlines()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines?.articles.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !didheadlinesLoad {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellId, for: indexPath) as! LoadingIndicatorTableViewCell
            cell.refreshButton.isHidden = true
            cell.activityIndicator.startAnimating()
            cell.refreshDelegate = self
            if didHeadlinesFailToLoad {
                cell.activityIndicator.stopAnimating()
                cell.refreshButton.setTitle("Tap here to refresh News feed", for: .normal)
                cell.refreshButton.isHidden = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: headlinesCellId, for: indexPath) as! HeadlineTableViewCell
            if let article = headlines?.articles[indexPath.row] {
                cell.article = article
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard didheadlinesLoad else {return}
        if let detailsVC: NewsDetailViewController = GET_VIEW_CONTROLLER(storyBoardName: newsStoryboard, storyBoardId: NewsDetailViewController.storyBoardId) {
            if let article = headlines?.articles[indexPath.row] {
                detailsVC.article = article
            }
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension HeadLinesListTableViewController: RefreshAPIFailureCellDelegate {
    func refreshFailedNetwork() {
        fetchHeadlines()
    }
}

///global function to get VC instance
func GET_VIEW_CONTROLLER<T: UIViewController>(storyBoardName: String, storyBoardId: String) -> T? {
    let storyboard = UIStoryboard.init(name: storyBoardName, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: storyBoardId)
    return viewController as? T ?? nil
}
