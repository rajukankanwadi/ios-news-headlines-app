//
//  Conctants.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 26/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import Foundation

struct Constants {
    let robotoBold12pt = ScaledFont.robotoSlabBold.font(forTextStyle: .caption1)
    let robotoBold20pt = ScaledFont.robotoSlabBold.font(forTextStyle: .title3)
    let robotoBold29pt = ScaledFont.robotoSlabBold.font(forTextStyle: .title1)
    let robotoBold18pt = ScaledFont.robotoSlabBold.font(forTextStyle: .headline)
    let robotoRegular14pt = ScaledFont.robotoSlab.font(forTextStyle: .caption1)
    let robotoRegular20pt = ScaledFont.robotoSlab.font(forTextStyle: .headline)

    struct URL {
        let headLinesUrl = "https://newsapi.org/v2/top-headlines"
    }
}

