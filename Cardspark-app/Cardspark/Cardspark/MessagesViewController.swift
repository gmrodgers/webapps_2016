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
  var messages = [Message]()
  
  var outgoingBubbleImageView: JSQMessagesBubbleImage!
  var incomingBubbleImageView: JSQMessagesBubbleImage!
  
  var rootRef = FIRDatabase.database().reference()
  var messageRef: FIRDatabaseReference!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Messenger"
    setupBubbles()
    
    inputToolbar.contentView.leftBarButtonItem = nil
    automaticallyScrollsToMostRecentMessage = true
    
    // These need to be set properly
    self.senderId = AppState.sharedInstance.userID
    self.senderDisplayName = ""
    
    // No avatars
    collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
    collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    
    messageRef = rootRef.child("messages")
    
    observeMessages()
  
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
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
    if message.senderId() == senderId {
        return outgoingBubbleImageView
    } else {
      return incomingBubbleImageView
    }
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
    return nil
  }
  
  func addMessage(id: String, text: String) {
    let message = Message(senderId: id, senderDisplayName: "", isMediaMessage: false, hash: 0, text: text)
    messages.append(message)
  }
  
  
  override func collectionView(collectionView: UICollectionView,
                               cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
      as! JSQMessagesCollectionViewCell
    
    let message = messages[indexPath.item]
    
    if message.senderId() == senderId {
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
      "senderId": senderId
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
      self.addMessage(id, text: text)
      self.finishReceivingMessage()
    })
  }
  
  // View  usernames above bubbles
  override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
    let message = messages[indexPath.item];
    
    // Sent by me, skip
    if message.senderId() == senderId {
      return nil;
    }
    
    // Same as previous sender, skip
    if indexPath.item > 0 {
      let previousMessage = messages[indexPath.item - 1];
      if previousMessage.senderId() == message.senderId() {
        return nil;
      }
    }
    
    return NSAttributedString(string:message.senderId())
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
    let message = messages[indexPath.item]
    
    // Sent by me, skip
    if message.senderId() == senderId {
      return CGFloat(0.0);
    }
    
    // Same as previous sender, skip
    if indexPath.item > 0 {
      let previousMessage = messages[indexPath.item - 1];
      if previousMessage.senderId() == message.senderId() {
        return CGFloat(0.0);
      }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault
  }
}
