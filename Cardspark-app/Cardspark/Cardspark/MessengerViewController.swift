//
//  MessengerViewController.swift
//  Cardspark
//
//  Created by Leanne Lyons on 30/05/2016.
//  Copyright © 2016 Mango Productions. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class MessengerViewController: JSQMessagesViewController {
  
//  // MARK: Properties
//  var messages = [JSQMessage]()
//  
//  var outgoingBubbleImageView: JSQMessagesBubbleImage!
//  var incomingBubbleImageView: JSQMessagesBubbleImage!
//  
  override func viewDidLoad() {
    super.viewDidLoad()
//    title = "Messenger"
//    setupBubbles()
//    
//    // No avatars
//    collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
//    collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
  }
//
//  override func collectionView(collectionView: JSQMessagesCollectionView!,
//                               messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
//    return messages[indexPath.item]
//  }
//  
//  override func collectionView(collectionView: UICollectionView,
//                               numberOfItemsInSection section: Int) -> Int {
//    return messages.count
//  }
//  
//  private func setupBubbles() {
//    let factory = JSQMessagesBubbleImageFactory()
//    outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
//      UIColor.jsq_messageBubbleBlueColor())
//    incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
//      UIColor.jsq_messageBubbleLightGrayColor())
//  }
//
//  override func collectionView(collectionView: JSQMessagesCollectionView!,
//                               messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
//    let message = messages[indexPath.item] // 1
//    if message.senderId == senderId { // 2
//      return outgoingBubbleImageView
//    } else { // 3
//      return incomingBubbleImageView
//    }
//  }
//  
//  override func collectionView(collectionView: JSQMessagesCollectionView!,
//                               avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
//    return nil
//  }
  

}
