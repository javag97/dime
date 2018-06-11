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
        UIApplication.shared.openURL(myLink!)
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
            do {
                let data: Data = try Data(contentsOf: myImage!)
                image.image = UIImage(data: data)
            } catch {
                // error handling
                print("error")
            }
        
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
