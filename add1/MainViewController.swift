//
//  MainViewController.swift
//  add1
//
//  Created by User19 on 2019/1/7.
//  Copyright © 2019 laura. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    @IBOutlet weak var numbersLabel:UILabel?
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    
    
    var score:Int = 0
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        inputField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for:UIControl.Event.editingChanged)
    }
    
    func updateScoreLabel()
    {
        scoreLabel?.text = "\(score)"
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
                
                
                
                score += 1
            }
            else
            {
                print("Incorrect！")
                
                
                
                score -= 1
            }
        }
        setRandomNumberLabel()
        updateScoreLabel()
        
        
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
