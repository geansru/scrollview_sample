//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by Dmitry Roytman on 04.04.16.
//  Copyright © 2016 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
  var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
  var currentIndex: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource = self
    
    if let viewController = getViewPhotoCommentController(currentIndex ?? 0) {
      let viewControllers = [viewController]
      setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    }
  }
  // helper
  func getViewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
    if let storyboard = storyboard, page = storyboard.instantiateViewControllerWithIdentifier("PhotoCommentViewController") as? PhotoCommentViewController {
      page.photoName = photos[index]
      page.photoIndex = index
      return page
    }
    return nil
  }
}

//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController: UIPageViewControllerDataSource {
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController {
      var index = viewController.photoIndex
      guard index != NSNotFound && index != 0 else { return nil }
      index = index - 1
      return getViewPhotoCommentController(index)
    }
    return nil
  }
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController {
      var index = viewController.photoIndex
      guard index != NSNotFound else { return nil }
      index = index + 1
      guard index != photos.count else { return nil }
      return getViewPhotoCommentController(index)
    }
    return nil
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
  }
}