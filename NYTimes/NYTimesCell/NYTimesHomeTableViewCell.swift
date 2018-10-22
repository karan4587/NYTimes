//
//  NYTimesHomeTableViewCell.swift
//  NYTimes
//
//  Created by Karan Thakkar on 21/10/18.
//  Copyright © 2018 TLIKnowledge. All rights reserved.
//

import UIKit

class NYTimesHomeTableViewCell : UITableViewCell
{
    @IBOutlet weak var newsImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var byAutorTitle : UILabel!
    @IBOutlet weak var publishDateLabel : UILabel!
    
    func displayNewsData(newsData: NSDictionary)
    {
        var newsImageArray = newsData["media"] as? [Any] ?? []
        var newsImageInfoDictionary = newsImageArray[0] as? [AnyHashable: Any]
        var newsImageMetaDataArray = newsImageInfoDictionary?["media-metadata"] as? [Any]
        
        newsImageView.image = nil
        if newsImageMetaDataArray != nil
        {
            var newsFeedImageDictionary = newsImageMetaDataArray?[1] as? [AnyHashable: Any]
            let imageURL = URL(string: newsFeedImageDictionary?["url"] as? String ?? "")
            if imageURL != nil{
                newsImageView.layer.cornerRadius = newsImageView.frame.height/2
                newsImageView.layer.masksToBounds = true
                let imageData:NSData = NSData(contentsOf: imageURL!)!
                newsImageView.image = UIImage(data: imageData as Data)
            }
        }
        
        titleLabel.text = ""
        if let titleText = newsData.value(forKey: "title") as? String
        {
            titleLabel.text = titleText
        }
        
        byAutorTitle.text = ""
        if let byAuthorText = newsData.value(forKey: "byline") as? String
        {
            byAutorTitle.text = byAuthorText
        }
        
        publishDateLabel.text = ""
        if let publishDateText = newsData.value(forKey: "published_date") as? String
        {
            publishDateLabel.text = publishDateText
        }
    }
}
