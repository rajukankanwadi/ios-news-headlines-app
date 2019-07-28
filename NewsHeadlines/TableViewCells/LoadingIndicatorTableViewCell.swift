//
//  LoadingIndicatorTableViewCell.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 28/07/19.
//  Copyright © 2019 Cox Communications. All rights reserved.
//

import UIKit

protocol RefreshAPIFailureCellDelegate: class {
    func refreshFailedNetwork(currentAPI: String)
}
class LoadingIndicatorTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIButton!
    var failedApiString: String = ""

    weak var refreshDelegate: RefreshAPIFailureCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func refreshStatementsTapped(_ sender: Any) {
        self.activityIndicator.startAnimating()
        self.refreshButton.isHidden = true
        refreshDelegate?.refreshFailedNetwork(currentAPI: failedApiString)
    }
}
