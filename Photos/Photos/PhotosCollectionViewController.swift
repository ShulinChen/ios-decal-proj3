//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo]!
    var indexPhoto = 0
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    

    
//    override func prepareForSegue(segue: UIStoryboardSegue,sender:AnyObject?){
//        if segue.identifier = ”goToViewB” {
//            let nav =
//            segue.destinationViewController as! UINavigationViewController
//            let targetVC = nav.viewControllers.first as! BViewController
//            targetVC.someValue = self.someValue
//        }
//    }

        //transition twice!
//        override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//            indexPhoto = indexPath.row
//            performSegueWithIdentifier("imagePointer", sender: self)
//        }
    
    func collectionView(collection: UICollectionView, selectedItemIndex: NSIndexPath) {
        self.performSegueWithIdentifier("imagePointer", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "imagePointer") {
            if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
                    let detailVC = segue.destinationViewController as! SingleController
                    detailVC.photoForDetail = self.photos[indexPath.row]
            }
        }
    }
    

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos != nil {
          return photos.count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        var photo = photos[indexPath.row]
        //download the image url from photo..set it
        
        var imgURL: NSURL = NSURL(string: photo.url)!
        
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                if error == nil {
                    cell.imageView.image = UIImage(data: data!)
                }
        })
        return cell
    }
    
    //when clicking on a photo.. it goes to another detailed view
    //func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
     //   code
    //}
    
    
    
    func loadImageForCell(photo: Photo, imageView: UIImageView, indexPath: NSIndexPath) {
        
        
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

