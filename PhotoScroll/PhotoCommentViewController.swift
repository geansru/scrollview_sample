//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Dmitry Roytman on 04.04.16.
//  Copyright © 2016 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var textField: UITextField!
  
  @IBAction func hideKeyboard() {
    textField.endEditing(true)
  }
  @IBAction func openZoomingController(sender: AnyObject) {
    self.performSegueWithIdentifier("zooming", sender: nil)
  }
  
  override public func prepareForSegue(segue: UIStoryboardSegue,
    sender: AnyObject?) {
      if let id = segue.identifier,
        zoomedPhotoViewController = segue.destinationViewController as? ZoomedPhotoViewController {
          if id == "zooming" {
            zoomedPhotoViewController.photoName = photoName
          }
      }
  }
  
  var photoName: String!
    override func viewDidLoad() {
        super.viewDidLoad()

      if let photoName = photoName { imageView.image = UIImage(named: photoName) }
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
  internal var photoIndex: Int!
  
  func keyboardWillShow(notification: NSNotification) {
    adjustInsetForKeyboardShow(true, notification: notification)
  }
  func keyboardWillHide(notification: NSNotification) {
    adjustInsetForKeyboardShow(false, notification: notification)
  }
  
  func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
    guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
    let keyboardFrame = value.CGRectValue()
    let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 20) * (show ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
}
