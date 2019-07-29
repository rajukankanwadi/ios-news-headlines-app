//
//  HeadlineTableViewCell.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 26/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var sourcelabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!
    @IBOutlet weak var cardBackGroundImageView: CustomImageView!

    var article: Article? {
        didSet {
            self.headlineTextLabel.text = article?.title
            self.sourcelabel.text = article?.source?.name
            if let date = article?.publishedAt {
                self.postedDateLabel.text = date.convertDateString(from: "yyyy-MM-dd'T'HH:mm:ssZ", to: "yyyy-MM-dd")
            }
            setImageView()
        }
    }

    func setImageView() {
        if let imageUrl = article?.urlToImage {
            cardBackGroundImageView.loadImageUsingUrl(urlString: imageUrl)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageView?.layoutIfNeeded()
        self.contentView.layoutSubviews()
        let constants = Constants()
        self.headlineTextLabel.font = constants.robotoRegular20pt
        self.postedDateLabel.font = constants.robotoBold12pt
        self.sourcelabel.font = constants.robotoBold12pt

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension String {
    func convertDateString(from format: String, to destinationFormat: String) -> String {
        if self == "" {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date: Date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = destinationFormat
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
