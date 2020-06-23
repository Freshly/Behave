//
//  API.swift
//  MobileTestPR
//
//  Created by Derek Bronston on 12/18/18.
//  Copyright © 2018 Freshly. All rights reserved.
//

import Foundation
import Alamofire

class pr : URLProtocol {
    override class func canInit(with task: URLSessionTask) -> Bool {
        return false
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return URLRequest(url:URL(string: "")!)
    }
}

protocol APIProtocol {
    func login(email:String,password:String,success: @escaping()->Void,fail: @escaping(String)->Void)
}

struct API: APIProtocol {

    func login(email:String,password:String,success: @escaping()->Void,fail: @escaping(String)->Void){
        let params = ["email":email,"password":password]
        AF.request(URLS.login.rawValue,method:.post,parameters:params).responseJSON { response in
            if let d = response.value as? [String:AnyObject]{
                if response.response!.statusCode > 200 {
                    if let error = d["error"] as? String {
                        fail(error)
                        return
                    }else {
                        fail(Strings.error.rawValue)
                        return
                    }
                }
                if response.response!.statusCode == 200 {
                    if let _ = d["success"] {
                        success()
                        return
                    } else {
                        fail(Strings.error.rawValue)
                        return
                    }
                }
            }
        }
        
    }
}
