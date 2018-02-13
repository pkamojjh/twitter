//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var userName: String?
    var profile: String?
    var profileImage: URL?
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        userName = dictionary["screen_name"] as? String
        profile = dictionary["profile_image_url_https"] as? String
        profileImage = URL(string: profile!)
    }
}
