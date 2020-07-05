//
//  ViewController.swift
//  catchMeDemo
//
//  Created by Eren FAIKOGLU on 07.06.2020.
//  Copyright © 2020 Eren FAIKOGLU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var highest: UILabel!
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var icon4: UIImageView!
    @IBOutlet weak var icon5: UIImageView!
    @IBOutlet weak var icon6: UIImageView!
    @IBOutlet weak var icon7: UIImageView!
    @IBOutlet weak var icon8: UIImageView!
    @IBOutlet weak var icon9: UIImageView!
    
    
    var point = 0
    var high = 0
    var time = 0
    var timer = Timer()
    var count = 10
    var iconArray = [UIImageView]()
    var timerHide = Timer()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let maxScore = UserDefaults.standard.object(forKey: "maxScore"){
                highest.text = maxScore as? String
                 }
        
        
        icon1.isUserInteractionEnabled = true
        icon2.isUserInteractionEnabled = true
        icon3.isUserInteractionEnabled = true
        icon4.isUserInteractionEnabled = true
        icon5.isUserInteractionEnabled = true
        icon6.isUserInteractionEnabled = true
        icon7.isUserInteractionEnabled = true
        icon8.isUserInteractionEnabled = true
        icon9.isUserInteractionEnabled = true
                
        let rec1 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec2 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec3 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec4 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec5 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec6 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec7 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec8 = UITapGestureRecognizer(target: self, action: #selector(plus))
        let rec9 = UITapGestureRecognizer(target: self, action: #selector(plus))
        
        icon1.addGestureRecognizer(rec1)
        icon2.addGestureRecognizer(rec2)
        icon3.addGestureRecognizer(rec3)
        icon4.addGestureRecognizer(rec4)
        icon5.addGestureRecognizer(rec5)
        icon6.addGestureRecognizer(rec6)
        icon7.addGestureRecognizer(rec7)
        icon8.addGestureRecognizer(rec8)
        icon9.addGestureRecognizer(rec9)
        
        iconArray = [icon1, icon2, icon3, icon4, icon5, icon6, icon7, icon8, icon9]
        
        timeLeft.text = String(count)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(objTimer), userInfo: nil, repeats: true)
        timerHide = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hideIcon), userInfo: nil, repeats: true)
        
        hideIcon()
    }
    
    @objc func hideIcon()
    {
        for icon in iconArray{
            icon.isHidden = true
        }
        
        let rand = Int(arc4random_uniform(UInt32(iconArray.count - 1)))
        iconArray[rand].isHidden = false
    }
    
    @objc func plus() {
        point += 1
        score.text = String(point)
    }
    
    @objc func objTimer() {
        count -= 1
        timeLeft.text = String(count)
        if count <= 0 {
            if let maxScore = UserDefaults.standard.object(forKey: "maxScore"){
                if point > maxScore as! Int
                {
                    UserDefaults.standard.set(point, forKey: "maxScore")
                    highest.text = String(point)
                }
            } else {
                UserDefaults.standard.set(point, forKey: "maxScore")
                highest.text = String(point)
            }
            // alert
            let alert = UIAlertController(title: "Time's over!", message: "Would you like to play again?", preferredStyle: UIAlertController.Style.alert)
            let alertOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let alertPlay = UIAlertAction(title: "Lets play!", style: UIAlertAction.Style.default) { (alertPlay) in
                
                self.point = 0
                self.count = 10
                self.score.text = "0"
                self.timeLeft.text = String(self.count)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.objTimer), userInfo: nil, repeats: true)
                self.timerHide = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideIcon), userInfo: nil, repeats: true)
                
                
                
            }
            alert.addAction(alertOK)
            alert.addAction(alertPlay)
            self.present(alert, animated: true, completion: nil)
            timer.invalidate()
            timerHide.invalidate()
            for icon in iconArray{
                icon.isHidden = true
                
            }
            
        }
    }
    @IBAction func reset(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "maxScore")
        highest.text = "0"
    }
    

}

