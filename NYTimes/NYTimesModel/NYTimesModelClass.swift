//
//  NYTimesModelClass.swift
//  NYTimes
//
//  Created by Karan Thakkar on 22/10/18.
//  Copyright © 2018 TLIKnowledge. All rights reserved.
//

import UIKit

class NYTimesModel: NSObject {
    func searchMostPopularNewsModel(searchString : String, mostPopularNewsArray : NSMutableArray) -> NSMutableArray? {
        if searchString.isEmpty == false
        {
            let filteredArray = NSMutableArray()
            let predicate:NSPredicate!
            predicate = NSPredicate.init(format: "title contains[c] %@", searchString)
            let tempfilterArray = mostPopularNewsArray.filtered(using: predicate)
            if tempfilterArray.isEmpty == false {
                filteredArray.addObjects(from: tempfilterArray)
            }
            return filteredArray
        }
        return mostPopularNewsArray
    }
}
