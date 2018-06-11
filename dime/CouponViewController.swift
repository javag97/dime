//
//  CouponViewController.swift
//  dime
//
//  Created by Javier Garcia on 6/4/18.
//  Copyright © 2018 Javier Garcia. All rights reserved.
//
//        let attributedString = NSMutableAttributedString(string: "The next Starbucks® Happy Hour is Thursday, June 7. a Latte or Macchiato, size grande and larger, starting at 3 p.m. Offer valid 6/7 only after 3 p.m. at participating Starbucks® stores in the U.S. Receive 50% off grande or larger handcrafted Starbucks® Lattes or Macchiatos.")
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 1.2 // Whatever line spacing you want in points
//        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
//        couponDescription.attributedText = attributedString;

import UIKit

class CouponViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var couponTitle: UILabel!
    @IBOutlet weak var couponDescription: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        print("Test")
        UIApplication.shared.openURL(myLink!)
        print("test")
    }
    
    
    var myTitle = String()
    var myDescription = String()
    var myImage = URL(string: "")
    var myLink = URL(string: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        couponTitle.text = myTitle
        couponDescription.text = myDescription
        
        if let url = URL(string: "https://images.unsplash.com/photo-1499365094259-713ae26508c5?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=26d4766855746c603e3d42aaec633144&auto=format&fit=crop&w=1050&q=80") {
            do {
                let data: Data = try Data(contentsOf: myImage!)
                image.image = UIImage(data: data)
            } catch {
                // error handling
            }
        }
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
