//
//  MainViewController.swift
//  add1
//
//  Created by User19 on 2019/1/7.
//  Copyright © 2019 laura. All rights reserved.
//

import UIKit

import MBProgressHUD
class MainViewController: UIViewController {
    @IBOutlet weak var numbersLabel:UILabel?
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    @IBOutlet weak var timeLabel:UILabel?
    
    var score:Int = 0
    
    var hud:MBProgressHUD?
    
    var timer:Timer?
    var seconds:Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = MBProgressHUD(view:self.view)
        
        if(hud != nil)
        {
            self.view.addSubview(hud!)
        }
        
        setRandomNumberLabel()
        updateScoreLabel()
        
        inputField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for:UIControl.Event.editingChanged)
    }
    
    func updateScoreLabel()
    {
        scoreLabel?.text = "\(score)"
    }
    
    func updateTimeLabel()
    {
        if(timeLabel != nil)
        {
            let min:Int = (seconds / 60) % 60
            let sec:Int = seconds % 60
            
            let min_p:String = String(format: "%02d", min)
            let sec_p:String = String(format: "%02d", sec)
            
            timeLabel!.text = "\(min_p):\(sec_p)"
        }
    }
    
    func setRandomNumberLabel()
    {
        numbersLabel?.text = generateRandonString()
    }
    
    @objc func textFieldDidChange(textField:UITextField)
    {
        if inputField?.text?.characters.count ?? 0 < 4
        {
            return
        }
        if let numbers_text = numbersLabel?.text,
           let input_text = inputField?.text,
           let numbers = Int(numbers_text),
           let input = Int(input_text)
        {
            print("Comparing: \(input_text) minus \(numbers_text) == \(input - numbers)")
            
            if(input - numbers == 1111)
            {
                print("Correct！")
                
                showHUDWithAnswer(isRight: true)
                score += 1
            }
            else
            {
                print("Incorrect！")
                
                showHUDWithAnswer(isRight: false)

                score -= 1
            }
        }
        setRandomNumberLabel()
        updateScoreLabel()
        
        if(timer == nil)
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(onUpdateTimer), userInfo:nil, repeats:true)
        }
        
    }
    @objc func onUpdateTimer() -> Void
    {
        if(seconds > 0 && seconds <= 60)
        {
            seconds -= 1
            
            updateTimeLabel()
        }
        else if(seconds == 0)
        {
            if(timer != nil)
            {
                timer!.invalidate()
                timer = nil
            }
        }
    }
    func showHUDWithAnswer(isRight:Bool)
    {
        var imageView:UIImageView?
        
        if isRight
        {
            imageView = UIImageView(image: UIImage(named:"thumbs-up"))
        }
        else
        {
            imageView = UIImageView(image: UIImage(named:"thumbs-down"))
        }
        
        if(imageView != nil)
        {
            hud?.mode = MBProgressHUDMode.customView
            hud?.customView = imageView
            
            hud?.show(animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hud?.hide(animated: true)
                self.inputField?.text = ""
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Do any additional setup after loading the view.
    }
    
    func generateRandonString() -> String
    {
        var result:String = ""
        for _ in 1...4
        {
            var digit:Int = Int(arc4random_uniform(8)+1)
            result += "\(digit)"
        }
        
        return result
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
