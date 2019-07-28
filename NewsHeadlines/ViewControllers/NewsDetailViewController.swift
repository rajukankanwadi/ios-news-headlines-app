//
//  NewsDetailViewController.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 28/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var headlineTitle: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var article: Article?

    static let storyBoardId = "NewsDetailVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDetails()
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }

    func populateDetails() {
        self.headlineTitle.text = article?.title ?? ""
        self.descriptionLabel.text = article?.content ?? ""
        self.sourceLabel.text = article?.source?.name ?? ""
        if let imageUrl = article?.urlToImage {
            if let imageFromCache = imageCache.object(forKey: imageUrl as NSString) {
                self.newsImageView.image = imageFromCache
            }
        }
        if let date = article?.publishedAt {
            dateLabel.text = date.convertDateString(from: "yyyy-MM-dd'T'HH:mm:ssZ", to: "yyyy-MM-dd")
        }
    }

    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
        backButton.tintColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
}
