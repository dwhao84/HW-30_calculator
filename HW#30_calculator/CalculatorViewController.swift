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
 
 sender.tag == 1 //num 0
 sender.tag == 2 //num 1
 sender.tag == 3 //num 2
 sender.tag == 4 //num 3
 sender.tag == 5 //num 4
 sender.tag == 6 //num 5
 sender.tag == 7 //num 6
 sender.tag == 8 //num 7
 sender.tag == 9 //num 8
 sender.tag == 10 // num 9
 sender.tag == 11 // btnAllClear
 sender.tag == 12 // btnPlusForwardslashMinus
 
 sender.tag == 13 // percent
 sender.tag == 14 // Divide
 sender.tag == 15 // multiply
 sender.tag == 16 // minus
 sender.tag == 17 // plus
 sender.tag == 18 // equal
 sender.tag == 19 // Dot
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
    @IBOutlet weak var dotBtn: UIButton!
    @IBOutlet weak var equalBtn: UIButton!


    //呈現計算的狀態>>> 是或不是
    var performingMath: Bool = false
    //計算按鈕的點擊次數
    var btnTappedCount: Int  = 0
    //總數的字串
    var equation:       String = ""
    //小數點
    var decimals: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始設定numberLabel.text的數字為0
        numberLabel.text = "0"
        //調整文字至符合寬度
        numberLabel.adjustsFontSizeToFitWidth = true


    }


    @IBAction func numberButtonTapped(_ sender: UIButton) {

        let numberTag = sender.tag
        //當計算的數字超過第一個是字數時
        if performingMath == true {
            numberLabel.text = String(numberTag - 1)
            performingMath = false

        } else {
            //判斷第一位數是否為"0"
            if numberLabel.text != "0" {
                numberLabel.text! += String(numberTag - 1)
            } else {
                numberLabel.text = ""
                numberLabel.text! += String(numberTag - 1)
            }
        } ; print(numberTag-1)
    }



    @IBAction func operatorsBtnTapped(_ sender: UIButton) {
        //布林值decimals ＝true時代表為小數點
        var doubleNum: String
        if performingMath == true {
            doubleNum = ".0"
        } else {
            doubleNum = ""
        }

        if let inputNum = numberLabel.text {
            switch sender.tag {
                case 14:
                    equation = inputNum + doubleNum + "/"
                    print("divide")
                case 15:
                    equation = inputNum + doubleNum + "*"
                    print("multiply")
                case 16:
                    equation = inputNum + "-" + doubleNum
                    print("minus")
                case 17:
                    equation = inputNum + "+" + doubleNum
                    print("plus")
                default:
                    break
            }
        } ;print(equation)
    }


    @IBAction func equalBtnTapped(_ sender: UIButton) {

        if let inputNum = numberLabel.text {
            equation += inputNum
            print(equation)

        }
            let expression = NSExpression(format: equation)
            if let calculateResult = expression.expressionValue(with: nil, context: nil) as? Double {
                        print(calculateResult)
                        if calculateResult.truncatingRemainder(dividingBy: 1) == 0 {
                            numberLabel.text = String(calculateResult.floor(toInteger: 1))
                            print(calculateResult)
                        } else {
                            numberLabel.text = String(calculateResult.rounding(toDecimal: 6))
                }
            } 
        }

    @IBAction func dotBtnTapped(_ sender: UIButton) {
        btnTappedCount += 1
        if btnTappedCount == 1 {
            numberLabel.text! += "."
            decimals = true
        } else if btnTappedCount > 1 {
            numberLabel.text! += ""
            print("dotBtnTappedError")
            decimals = false
        }
    }
    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        numberLabel.text = "0"
        equation = ""
        btnTappedCount = 0
        print("clearBtnTapped")
    }


    @IBAction func btnPlusForwardslashMinusBtnTapped(_ sender: UIButton) {
        //把numberLabel.text用if let轉換成resultNum
        if let resultNum = numberLabel.text {
            //建立一個if else判斷式，當resultNum不等於0
            if resultNum != "0" {
                if let doubleResultNum = Double(resultNum) {
                    if doubleResultNum > 0 {
                        //當小數點等於正確的時候
                        if decimals == true {
                            numberLabel.text = "-\(doubleResultNum)"
                            print("1")
                            print(doubleResultNum)
                        } else {
                            numberLabel.text = "-\(Int(doubleResultNum))"
                            print("2")
                            print(doubleResultNum)
                        }
                    } else {
                        //當小數點等於正確的時候
                        //使用abs(), 將資料轉換成numberLabel.text
                        if decimals == true {
                            numberLabel.text = "\(abs(doubleResultNum))"
                            print("3")
                            print(doubleResultNum)
                        } else {
                            //將numberLabel.text使用abs()再加上Int(), 將資料轉換成"\(abs(Int(doubleResultNum)))"
                            numberLabel.text = "\(abs(Int(doubleResultNum)))"
                            print("4")
                            print(doubleResultNum)
                        }
                    }
                }
            }
        }
    }

    @IBAction func percentageBtnTapped(_ sender: UIButton) {

        let number = Double(numberLabel.text!) ?? 0.0
        let percentageNum = number / 100

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 10

        if let formattedPercentageNum = numberFormatter.string(from: NSNumber(value: percentageNum)) {
            numberLabel.text = formattedPercentageNum
            print(formattedPercentageNum)
        }
    }

}


