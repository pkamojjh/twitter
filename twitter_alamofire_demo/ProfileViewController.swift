//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pallav Kamojjhala on 2/20/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if let error = error {
                print (error)
            } else if let user = user {
                print("This is \(user.name)'s profile")
                self.nameLabel.text = user.name
                self.tagLabel.text = "@" + user.userName!
                self.imgView.af_setImage(withURL: user.profileImage!)
                self.followersLabel.text = "Followers: " + "\(user.followersCount!)"
                self.followingLabel.text = "Following: " + "\(user.followingCount!)"
                self.tweetsLabel.text = "Tweets: " + "\(user.totalTweets!)"
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
