//
//  MessagesViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 30/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class MessagesViewController: JSQMessagesViewController {

  // MARK: Properties
  var messages = [JSQMessage]()
  
  var outgoingBubbleImageView: JSQMessagesBubbleImage!
  var incomingBubbleImageView: JSQMessagesBubbleImage!
  
  var rootRef = FIRDatabase.database().reference()
  var messageRef: FIRDatabaseReference!
  var userIsTypingRef: FIRDatabaseReference!
  
  var usersTypingQuery: FIRDatabaseQuery!
  
  var topicId = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Messenger"
    setupBubbles()
    
    inputToolbar.contentView.leftBarButtonItem = nil
    automaticallyScrollsToMostRecentMessage = true
    
    self.senderId = AppState.sharedInstance.userID
    self.senderDisplayName = AppState.sharedInstance.displayName
    
    collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
    collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    
    messageRef = rootRef.child("messages/\(topicId)")
    
    observeMessages()
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    observeTyping()
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!,
                               messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
    return messages[indexPath.item]
  }
  
  override func collectionView(collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  private func setupBubbles() {
    let factory = JSQMessagesBubbleImageFactory()
    outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
      UIColor.jsq_messageBubbleBlueColor())
    incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
      UIColor.jsq_messageBubbleLightGrayColor())
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!,
                               messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
    let message = messages[indexPath.item]
    if message.senderId == senderId {
      return outgoingBubbleImageView
    } else {
      return incomingBubbleImageView
    }
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!,
                               avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
    return nil
  }
  
  func addMessage(id: String, displayName : String, text: String, topicId: Int) {
    messages.append(JSQMessage(senderId: id, displayName: displayName, text: text))
  }
  
  
  override func collectionView(collectionView: UICollectionView,
                               cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
      as! JSQMessagesCollectionViewCell
    let message = messages[indexPath.item]
    if message.senderId == senderId {
      cell.textView!.textColor = UIColor.whiteColor()
    } else {
      cell.textView!.textColor = UIColor.blackColor()
    }
    
    return cell
  }
  
  override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!,
                                   senderDisplayName: String!, date: NSDate!) {
    
    let itemRef = messageRef.childByAutoId()
    let messageItem = [
      "text": text,
      "senderId": senderId,
      "displayName": senderDisplayName,
      "topicId": topicId
    ]
    itemRef.setValue(messageItem)
    JSQSystemSoundPlayer.jsq_playMessageSentSound()
    finishSendingMessage()
  }
  
  private func observeMessages() {
    let messagesQuery = messageRef.queryLimitedToLast(25)
    messagesQuery.observeEventType(.ChildAdded, withBlock: { snapshot in
      let text = snapshot.value!["text"] as! String
      let id = snapshot.value!["senderId"] as! String
      let name = snapshot.value!["displayName"] as! String
      let topicId = snapshot.value!["topicId"] as! Int
      self.addMessage(id, displayName: name, text: text, topicId: topicId)
      self.finishReceivingMessage()
    })
  }
  
  // View  usernames above bubbles
  override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
    let message = messages[indexPath.item];
    // Skip if I sent this messgage
    if message.senderId == senderId {
      return nil;
    }
    
    // Skip if message is from previous sender
    if indexPath.item > 0 {
      let previousMessage = messages[indexPath.item - 1];
      if previousMessage.senderId == message.senderId {
        return nil;
      }
    }
    return NSAttributedString(string:message.senderDisplayName)
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
    
    let message = messages[indexPath.item]
    
    // Skip if I sent this messgage
    if message.senderId == senderId {
      return CGFloat(0.0);
    }
    
    // Skip if message is from previous sender
    if indexPath.item > 0 {
      let previousMessage = messages[indexPath.item - 1];
      if previousMessage.senderId == message.senderId {
        return CGFloat(0.0);
      }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault
  }
  
  private var localTyping = false
  var isTyping: Bool {
    get {
      return localTyping
    }
    set {
      localTyping = newValue
      userIsTypingRef.setValue(newValue)
    }
  }
  
  private func observeTyping() {
    let typingIndicatorRef = rootRef.child("typingIndicator")
    userIsTypingRef = typingIndicatorRef.child(senderId)
    userIsTypingRef.onDisconnectRemoveValue()
    
    usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqualToValue(true)
    usersTypingQuery.observeEventType(.Value, withBlock: { snapshot in
      // If only you are typing don't show the indicator
      if snapshot.childrenCount == 1 && self.isTyping { return }
      
      // If others are typing
      self.showTypingIndicator = snapshot.childrenCount > 0
      self.scrollToBottomAnimated(true)
    })
  }
}
