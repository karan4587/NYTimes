//
//  Constant.swift
//  NYTimes
//
//  Created by Karan Thakkar on 18/10/18.
//  Copyright © 2018 TLIKnowledge. All rights reserved.
//

import Foundation

struct NYTimesConfig {
    struct NYTimesBackEndURL {
        static let nyTimesBaseURL = "https://api.nytimes.com/"
        static var nyTimesMostViewdArticles = "\(nyTimesBaseURL)svc/mostpopular/v2/mostviewed/all-sections/7.json"
    }
    
    struct NYTimesParam {
        static let APIKey = "api-key"
        static let APIKeyValue = "3c6569010ef24f9b8658bfb019c5d873"
    }
}



