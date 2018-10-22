//
//  ServiceCallMethod.swift
//  NYTimes
//
//  Created by Karan Thakkar on 18/10/18.
//  Copyright © 2018 TLIKnowledge. All rights reserved.
//

import UIKit

// keep all API call here at one place

class ServiceCallModel: NSObject {
    
    func callMostViewdAPI(completionHandler:@escaping(_ status:Int,_ info:Any?) -> Void)  {
        
        let headerDict : Dictionary = [NYTimesConfig.NYTimesParam.APIKey:NYTimesConfig.NYTimesParam.APIKeyValue];
        
        ServerConnectionManager.shared.perfomeServerRequestWithURL(serverURL: NYTimesConfig.NYTimesBackEndURL.nyTimesMostViewdArticles, headerDictionary: headerDict) { (status, info) in
            completionHandler(status,info)
        }
    }
}
