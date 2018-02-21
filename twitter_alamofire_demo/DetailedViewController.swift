//
//  DetailedViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pallav Kamojjhala on 2/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailedViewController: UIViewController {
    var tweet: Tweet!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButtom: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dpimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet {
            dateLabel.text = tweet.createdAtString
            nameLabel.text = tweet.user.name
            tweetLabel.text = tweet.text
            usernameLabel.text = "@" + tweet.user.userName!
            dpimg.af_setImage(withURL: tweet.user.profileImage!)
            
            likeButtom.setTitle(String(describing: tweet.favoriteCount!), for: UIControlState.normal )
            
            retweetButton.setTitle(String(tweet.retweetCount), for: UIControlState.normal)
            
            if(tweet.favorited)!{
                self.likeButtom.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
                
            } else{
                self.likeButtom.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal) }
            
            if(tweet.retweeted){
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            } else{
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal) }
            
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likedAction(_ sender: Any) {
        if ( tweet?.favorited != true) {
            print(tweet.favoriteCount!)
            tweet.favoriteCount! = (tweet.favoriteCount)! + 1
            likeButtom.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            likeButtom.setTitle(String(describing: tweet.favoriteCount!), for: UIControlState.normal )
            tweet.favorited = true
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print(" \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("\(tweet.text)")
                }
            }
        }
        else {
            
            tweet.favoriteCount = tweet.favoriteCount! - 1
            
            likeButtom.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            likeButtom.setTitle(String(describing: tweet.favoriteCount!), for: UIControlState.normal )
            tweet.favorited = false
            
            APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print(" \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("\(tweet.text)")
                }
            }
        }
        
        
        
    }
    
    @IBAction func retweetAction(_ sender: Any) {
        
        if ( tweet?.retweeted != true) {
            
            tweet.retweetCount += 1
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            retweetButton.setTitle(String(describing: tweet.retweetCount), for: UIControlState.normal )
            tweet.retweeted = true
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("\(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("\(tweet.text)")
                }
            }
        }
        else {
            
            tweet.retweetCount -= 1
            
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            retweetButton.setTitle(String(describing: tweet.retweetCount), for: UIControlState.normal )
            tweet.retweeted = false
            
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                    
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
