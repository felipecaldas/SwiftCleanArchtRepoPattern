//
//  HTTPUtils.swift
//  BabyNamesv2
//
//  Created by Felipe Caldas on 9/02/2016.
//  Copyright © 2016 FunkApps FMC. All rights reserved.
//

import UIKit

class HttpUtils {
    
    static func httpGet(request: NSURLRequest!, callback: (NSData, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
                callback(NSData(), error!.localizedDescription)
            } else {
                //let result = NSString(data: data!, encoding:  NSASCIIStringEncoding)!
                callback(data! , nil)
            }
        }
        task.resume()
    }
    
    static func postData(url: String, params: Dictionary<String, String>,
        completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
            
            // Indicate download
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            let url = NSURL(string: url)!
            //        print("URL: \(url)")
            let request = NSMutableURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            // Verify downloading data is allowed
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            } catch let error as NSError {
                print("Error in request post: \(error)")
                request.HTTPBody = nil
            } catch {
                print("Catch all error: \(error)")
            }
            
            // Post the data
            let task = session.dataTaskWithRequest(request) { data, response, error in
                completionHandler(data: data, response: response, error: error)
                
                // Stop download indication
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false // Stop download indication
                
            }
            
            task.resume()
            
    }
    
    static func postData(_url: String, data: String, completion: (jsonData: NSArray?, error: NSError?)->Void) {
        var jsonData: NSArray = []
        
        let post: NSString = "data=\(data)"
        let url = NSURL(string: _url)!
        let postData = post.dataUsingEncoding(NSUTF8StringEncoding)!
        
        let postLength = String(postData.length)
        //Setting up `request` is similar to using NSURLConnection
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {urlData, response, reponseError in
            
            if let receivedData = urlData {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if 200..<300 ~= res.statusCode {
                    do {
                        jsonData = try NSJSONSerialization.JSONObjectWithData(receivedData, options: []) as! NSArray
                        //On success, invoke `completion` with passing jsonData.
                        completion(jsonData: jsonData, error: nil)
                    } catch let error as NSError {
                        let returnedError = NSError(domain: "postData", code: 3, userInfo: [
                            "title": "HTTP Post Failed!",
                            "message": "Incorrect Data!",
                            "cause": error
                            ])
                        //On error, invoke `completion` with NSError.
                        completion(jsonData: nil, error: returnedError)
                    }
                } else {
                    let returnedError = NSError(domain: "postData", code: 1, userInfo: [
                        "title": "HTTP Post Failed!",
                        "message": "Connection failure!"
                        ])
                    //On error, invoke `completion` with NSError.
                    completion(jsonData: nil, error: returnedError)
                }
            } else {
                var userInfo: [NSObject: AnyObject] = [
                    "title": "HTTP Post Failed!",
                    "message": "Connection failure!"
                ]
                if let error = reponseError {
                    userInfo["message"] = error.localizedDescription
                    userInfo["cause"] = error
                }
                let returnedError = NSError(domain: "postDate", code: 2, userInfo: userInfo)
                //On error, invoke `completion` with NSError.
                completion(jsonData: nil, error: returnedError)
            }
        }
        task.resume()
        //You should not write any code after `task.resume()`
    }
}
