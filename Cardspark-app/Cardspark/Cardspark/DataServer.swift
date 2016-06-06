//
//  DataServer.swift
//  Cardspark
//
//  Created by William Aboh on 05/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import Foundation
import UIKit

class DataServer: NSObject, NSURLConnectionDelegate {
    let baseURL = "https://radiant-meadow-37906.herokuapp.com/"
    var controller = UIViewController()
    
    func loadTopicsList(email: String, controller: UIViewController) {
        self.controller = controller
        let route = "users/topics"
        let parameters = ["user_email" : email]
        NSLog("Connect with URL for loading topics")
        sendGetRequest(route, parameters: parameters, completionHandler: topicsListHandler)
    }
    
    func topicsListHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode == 200) {
            print("Everything is okay")
        }
    }
    
    func createNewUser(email: String) {
        let route = "users"
        let postData = ["email" : email]
        NSLog("Connect with URL for creating new user")
        sendPostRequest(route, parameters: nil, postData: postData, completionHandler: newUserHandler)
    }
    
    func newUserHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode == 200) {
            print("Everything is okay")
        }
    }
    
    func sendGetRequest(url: String, parameters: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = NSURL(string: baseURL + "\(url)?\(parameterString)")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
    }
    
    func sendPostRequest(url: String, parameters: [String: AnyObject]?, postData: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let parameterString = parameters?.stringFromHttpParameters()
        var requestURL = NSURL(string: "")!
        if ((parameterString) != nil) {
            requestURL = NSURL(string: baseURL + "\(url)?\(parameterString)")!
        } else {
            requestURL = NSURL(string: baseURL + "\(url)")!
        }
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "POST"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postData, options: NSJSONWritingOptions.PrettyPrinted)
        } catch {
            
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
    }
    
}

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}