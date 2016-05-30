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

  
  override func viewDidLoad() {
    super.viewDidLoad()
        title = "Messenger"
        setupBubbles()
    
    // These need to be set properly
    self.senderId = AppState.sharedInstance.displayName
    self.senderDisplayName = AppState.sharedInstance.displayName
    
    // No avatars
    collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
    collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    
    messageRef = rootRef.child("messages")
  
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
  
  func addMessage(id: String, text: String) {
    let message = JSQMessage(senderId: id, displayName: "", text: text)
    messages.append(message)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    finishReceivingMessage()
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
      "senderId": senderId
    ]
    itemRef.setValue(messageItem)
    
    JSQSystemSoundPlayer.jsq_playMessageSentSound()
    addMessage(senderId, text: text)
    
    finishSendingMessage()
  }
}
