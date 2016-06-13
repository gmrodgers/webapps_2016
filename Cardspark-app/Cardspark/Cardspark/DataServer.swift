//
//  DataServer.swift
//  Cardspark
//
//  Created by William Aboh on 07/06/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import Foundation
import UIKit

class DataServer: NSObject, NSURLConnectionDelegate {
  private let baseURL = "https://radiant-meadow-37906.herokuapp.com/"
  
  // MARK: App request actions
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
    
    if (statusCode == 200) {
      print("status code: \(statusCode), Everything is okay!")
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
  
  func createNewTopic(email: String, topic: Topic, controller: TopicsTableViewController) {
    let route = "users/topics"
    let postData = ["email" : email, "topic" : ["name" : topic.name, "colour" : topic.colour]]
    let httpMethod = "POST"
    NSLog("Connect with URL for creating new topic")
    sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData as! [String : AnyObject], completionHandler: controller.createTopicHandler)
  }
  
  func addNewTopicViewer(email: String, topic_id: Int) {
    let route = "users/topics/new_viewer"
    let postData = ["email" : email, "topic_id" : topic_id]
    let httpMethod = "POST"
    NSLog("Connect with URL for adding viewer to topic")
    sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData as! [String : AnyObject], completionHandler: addTopicViewerHandler)
  }
  
  private func addTopicViewerHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    if (statusCode > 0) {
      print("status code: \(statusCode)")
    }
  }
  
  func updateTopic(topic_id: Int, updated_topic: Topic) {
    let route = "topics"
    let postData = ["topic_id" : topic_id, "topic" : ["name" : updated_topic.name, "colour" : updated_topic.colour]]
    let httpMethod = "PUT"
    NSLog("Connect with URL for updating topic")
    sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData as! [String: AnyObject], completionHandler: updateTopicHandler)
  }
  
  private func updateTopicHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    if (statusCode > 0) {
      print("status code: \(statusCode)")
    }
  }
  
  func loadTopicsList(email: String, controller: TopicsTableViewController) {
    let route = "users/topics"
    let parameters = ["email" : email]
    let httpMethod = "GET"
    NSLog("Connect with URL for loading topics")
    sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: controller.loadTopicsListHandler)
  }
  
  func loadUsersList(topic_id: Int, controller: UsersTableViewController) {
    let route = "users/topics/viewers"
    let parameters = ["topic_id" : String(topic_id)]
    let httpMethod = "GET"
    NSLog("Connect with URL for loading users")
    sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: controller.loadUsersListHandler)
  }
  
  func deleteTopic(email: String, topic_id: Int, controller: TopicsTableViewController) {
    let route = "users/topics"
    let parameters = ["email" : email, "topic_id" : String(topic_id)]
    let httpMethod = "DELETE"
    NSLog("Connect with URL for deleting topic")
    sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: controller.deleteTopicHandler)
  }
  
  func createNewCard(card: Card, controller: CardTableViewController) {
    let route = "topics/cards"
    let postData = ["card" : ["topic_id" : String(card.topic_id), "cardname" : card.name, "card_data" : card.htmlData, "image_loc" : card.imageRef]]
    let httpMethod = "POST"
    NSLog("Connect with URL for creating new card")
    sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData, completionHandler: controller.createCardHandler)
  }
  
  func loadCardsList(topic_id : Int, controller: CardTableViewController) {
    let route = "topics/cards"
    let parameters = ["topic_id" : String(topic_id)]
    let httpMethod = "GET"
    NSLog("Connect with URL for loading cards")
    sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: controller.loadCardsListHandler)
  }
  
  func updateCard(card_id: Int, updated_card: Card) {
    let route = "cards"
    let postData = ["card_id" : card_id, "card" : ["topic_id" : updated_card.topic_id, "cardname" : updated_card.name, "card_data" : updated_card.htmlData]]
    let httpMethod = "PUT"
    NSLog("Connect with URL for updating topic")
    sendDataRequest(httpMethod, url: route, parameters: nil, inputData: postData as! [String: AnyObject], completionHandler: updateCardHandler)
  }
  
  private func updateCardHandler(data: NSData?, response: NSURLResponse?, err: NSError?) -> Void {
    let httpResponse = response as! NSHTTPURLResponse
    let statusCode = httpResponse.statusCode
    
    if (statusCode > 0) {
      print("status code: \(statusCode)")
    }
  }
  
  func deleteCard(card_id: Int, controller: CardTableViewController) {
    let route = "topics/cards"
    let parameters = ["card_id" : String(card_id)]
    let httpMethod = "DELETE"
    NSLog("Connect with URL for deleting topic")
    sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: controller.deleteCardHandler)
  }
  
  func loadQuiz(topic_id : Int, controller: QuizViewController) {
    let route = "topics/cards"
    let parameters = ["topic_id" : String(topic_id)]
    let httpMethod = "GET"
    NSLog("Connect with URL for loading cards for quiz")
    sendActionRequest(httpMethod, url: route, parameters: parameters, completionHandler: controller.loadQuizHandler)
  }
  
  // MARK: Server requests
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

// MARK: Extensions for encoding
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