//
//  CalculatorViewController.swift
//  HW#30_calculator
//
//  Created by Dawei Hao on 2023/6/30.
//
/*
 Practice Purpose
 1.先乘除後加減，比方 3 + 4 * 5 會得到 35。
 2.加入負數
 3.加入小數點
 4.點擊UIButton，按鈕顏色會變色(參考Iphone)
 5.加入Auto Layout
 6.當數字大於0時，btnAC轉成文字btnClear
*/

/*
 tag's value
 
 sender.tag == 0 //0
 sender.tag == 1 //1
 sender.tag == 2 //2
 sender.tag == 3 //3
 sender.tag == 4 //4
 sender.tag == 5 //5
 sender.tag == 6 //6
 sender.tag == 7 //7
 sender.tag == 8 //8
 sender.tag == 9 //9
 sender.tag == 10 // allClear
 sender.tag == 11 // plusForwardslashMinus
 sender.tag == 12 // percent
 
 sender.tag == 13 // Divide
 sender.tag == 14 // multiply
 sender.tag == 15 // minus
 sender.tag == 16 // plus
 sender.tag == 17 // equal
 */

import UIKit

class CalculatorViewController: UIViewController {

    //數字按鈕的Outlet Collection
    @IBOutlet var numbersBtn: [UIButton]!
    @IBOutlet weak var btnAllClear: UIButton!
    //加減乘除按鈕的Outlet Collection
    @IBOutlet var operatorsBtn: [UIButton]!
    @IBOutlet weak var btnPercentage: UIButton!
    @IBOutlet weak var btnPlusForwardslashMinus: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
     
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var performingMath = false
    var operation = 0
    
    var btnTappedCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //updateUI()
        
        //新增btnNegativeAndPostive點擊事件
        btnPlusForwardslashMinus.addTarget(self, action: #selector(negativeAndPlusBtnTapped), for: .touchUpInside)
    }

    func updateUI () {
        numberLabel.text = "0"
    }

    @IBAction func numberButtonTapped(_ sender: UIButton) {
        let numberTag = sender.tag
        print("numberButtonTapped")
        
        //if numberTag == 0 {
        //    btnAllClear.isHidden = false
        //    btnClear.isHidden = true
        //   print("numberTagEqualsZero")
        // } else if numberTag > 0 {
        //    btnAllClear.isHidden = true
        //    btnClear.isHidden = false
         //   print("numberTagOverZero")
        //}
    }
    
    @IBAction func operatorsBtnTapped(_ sender: UIButton) {
        let operatorTag = sender.tag
        print("operatorBtnTapped")
        // Divide
        if operatorTag == 13 { }
        else if operatorTag == 14 {
            print("Divide")
            
        }
        else if operatorTag == 15 {
            print("minus")
            
        }
        else if operatorTag == 16 {
            print("plus")
            
        }
        else if operatorTag == 17 {
            print("equal")
            
        }
    }
    
    
    
    
    @objc func negativeAndPlusBtnTapped() {
        btnTappedCount += 1
        print("negativeAndPlusBtnTapped")
        if btnTappedCount % 2 == 1 {
            numberLabel.text = String(-numberOnScreen)
            print("負數")
        } else if btnTappedCount % 2 == 0 {
            numberLabel.text = String(numberOnScreen)
            print("正數")
        }
    }
    
}
