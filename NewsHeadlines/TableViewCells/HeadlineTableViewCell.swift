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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
