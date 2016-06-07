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
    private let baseURL = "https://radiant-meadow-37906.herokuapp.com/"
    private var controller = UIViewController()

    
    func createNewUser(email: String) {
        let route = "users"
        let postData = ["email" : email]
        let httpMethod = "POST"
        NSLog("Connect with URL for creating new user")
        sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData, completionHandler: createUserHandler)
    }
    
    private func createUserHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode > 0) {
            print("status code: \(statusCode)")
        }
    }
    
    func updateUser(old_email: String, new_email: String) {
        let route = "users"
        let postData = ["user" : ["email" : old_email], "email" : new_email]
        let httpMethod = "PUT"
        NSLog("Connect with URL for updating user")
        sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData as! [String : AnyObject], completionHandler: updateUserHandler)
    }
    
    private func updateUserHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode > 0) {
            print("status code: \(statusCode)")
        }
    }
    
    func deleteUser(email: String) {
        let route = "users"
        let parameters = ["email" : email]
        let httpMethod = "DELETE"
        NSLog("Connect with URL for deleting user")
        sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: deleteUserHandler)
    }
    
    private func deleteUserHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode > 0) {
            print("status code: \(statusCode)")
        }
    }
    
    func createNewTopic(email: String, topic: Topic) {
        let route = "users/topics"
        let postData = ["email" : email, "topic" : ["name" : topic.name]]
        let httpMethod = "POST"
        NSLog("Connect with URL for creating new topic")
        sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData as! [String : AnyObject], completionHandler: createTopicHandler)
    }
    
    private func createTopicHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode > 0) {
            print("status code: \(statusCode)")
        }
    }
    
    func loadTopicsList(email: String, controller: UIViewController) {
        self.controller = controller
        let route = "users/topics"
        let parameters = ["email" : email]
        let httpMethod = "GET"
        NSLog("Connect with URL for loading topics")
        sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: loadTopicsListHandler)
    }
    
    private func loadTopicsListHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode > 0) {
            print("status code: \(statusCode)")
        }
    }
    
    private func sendActionRequest(httpMethod: String, url: String, parameters: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = NSURL(string: baseURL + "\(url)?\(parameterString)")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = httpMethod
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
    }
    
    private func sendDataRequest(httpMethod: String, url: String, parameters: [String: AnyObject]?, inputData: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let parameterString = parameters?.stringFromHttpParameters()
        var requestURL = NSURL(string: "")!
        if ((parameterString) != nil) {
            requestURL = NSURL(string: baseURL + "\(url)?\(parameterString)")!
        } else {
            requestURL = NSURL(string: baseURL + "\(url)")!
        }
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = httpMethod

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(inputData, options: NSJSONWritingOptions.PrettyPrinted)
        } catch {
            
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
    }
    
}

extension String {
    /// This percent escapes in compliance with RFC 3986: http://www.ietf.org/rfc/rfc3986.txt
    // Percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    //
    // returns: Returns percent-escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
}

extension Dictionary {
    // returns: Percent-escaped string representation of HTTP parameters e.g. key1=value1&key2=value2
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
}