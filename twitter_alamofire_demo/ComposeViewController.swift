//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Pallav Kamojjhala on 2/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit



protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
    
    
}

class ComposeViewController: UIViewController, UITextViewDelegate{
    
     var delegate: ComposeViewControllerDelegate!

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var charsLeft: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.getCurrentAccount(completion: { (user, error) in
            if let error = error {
                print (error)
            } else if let user = user {
                self.profilePicture.af_setImage(withURL: user.profileImage!)
                
            }
        })
        textView.delegate = self

        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetAction(_ sender: Any) {
        
        APIManager.shared.composeTweet(with: textView.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
    
        let characterLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        if (newText.characters.count < characterLimit+1){
            charsLeft.text = "\(characterLimit - newText.characters.count)"
            
        }
        else {
            tweetButton.isUserInteractionEnabled = false
            let alertController = UIAlertController(title: "Alert", message: "Character count not in limit!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
             
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
               
            }
            
        }
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
        
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
