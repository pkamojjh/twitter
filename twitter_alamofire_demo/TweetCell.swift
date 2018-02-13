//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButtom: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            
            
            profilePicture.af_setImage(withURL: tweet.user.profileImage!)
            tweetTextLabel.text = tweet.text
            dateLabel.text = tweet.createdAtString
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.userName!
            
            
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
