//
//  ServerConnectionManager.swift
//  NYTimes
//
//  Created by Karan Thakkar on 18/10/18.
//  Copyright © 2018 TLIKnowledge. All rights reserved.
//

import UIKit

enum ServerConnectionResponseStatus {
    case ServerConnectionResponseStatusSuccess,ServerConnectionResponseStatusFail
}

class ServerConnectionManager: NSObject {
    
    static let shared = ServerConnectionManager()
    
    private override init() {
    }
    
    // call ServerURL for GET request
    func perfomeServerRequestWithURL(serverURL:String, headerDictionary: [String:Any],  completionHandler:@escaping (_ status:Int,_ info:Any?) -> Void) {
        
        var urlRequest = URLRequest.init(url: URL.init(string: serverURL)!)
        
        for (key,value) in headerDictionary {
            urlRequest.setValue(value as? String , forHTTPHeaderField: key)
        }
        
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest){
            (data, response, error) -> Void in
            let result = try?JSONSerialization.jsonObject(with: data ?? Data.init(), options: JSONSerialization.ReadingOptions.allowFragments)
            if error == nil {
                completionHandler(ServerConnectionResponseStatus.ServerConnectionResponseStatusSuccess.hashValue,result)
            } else {
                completionHandler(ServerConnectionResponseStatus.ServerConnectionResponseStatusFail.hashValue,nil)
            }
        }
        task.resume()
    }
}
