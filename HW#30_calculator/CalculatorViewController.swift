//
//  CalculatorViewController.swift
//  HW#30_calculator
//
//  Created by Dawei Hao on 2023/6/30.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    @IBOutlet weak var buttonZero: UIButton!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    @IBOutlet weak var buttonDot: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMulti: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    @IBOutlet weak var buttonPercentage: UIButton!
    @IBOutlet weak var buttonNegativeAndPostive: UIButton!
    @IBOutlet weak var buttonAllClear: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        
    }
    
    
    
    
    
    
    func updateUI () {
        numberLabel.text = "0"
    }
    
    
    
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        print("allClearButtonTapped")
        numberLabel.text = "0"
        
    }
    
    @IBAction func negativeAndPostiveButtonTapped(_ sender: UIButton) {
        print("negativeAndPostiveButtonTapped")
        //let negativeNumber =
        //numberLabel.text =
    }
    
    @IBAction func percentageButtonTapped(_ sender: UIButton) {
        print("percentageButtonTapped")
        
    }
    
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        print("divideButtonTapped")
        
    }
    
    @IBAction func mulitButtonTapped(_ sender: UIButton) {
        print("mulitButtonTapped")
        
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        print("minusButtonTapped")
        
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        print("plusButtonTapped")
        
    }
    
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        print("equalButtonTapped")
        
    }
    
    @IBAction func dotButtonTapped(_ sender: UIButton) {
        print("dotButtonTapped")
        let value = Int(numberLabel.text ?? "0")
            // 检查 value 的值
            if value == 0 {
                updateUI()
            } else if value ?? 0 >= 1 {
             
            }
    }
    
    
    
    
}
