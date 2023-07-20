//
//  CalculatorViewController.swift
//  HW#30_calculator
//
//  Created by Dawei Hao on 2023/6/30.
//

import UIKit
import MathParser

class CalculatorViewController: UIViewController {

    //數字按鈕的Outlet Collection
    @IBOutlet var numbersBtn: [UIButton]!
    @IBOutlet weak var btnAllClear: UIButton!

    //加減乘除按鈕的Outlet Collection
    @IBOutlet var operatorsBtn: [UIButton]!
    @IBOutlet weak var btnPercentage: UIButton!
    @IBOutlet weak var btnPlusForwardslashMinus: UIButton!
    @IBOutlet weak var numberLabel: UILabel!

    //operator outlet
    @IBOutlet weak var dotBtn: UIButton!
    @IBOutlet weak var equalBtn: UIButton!
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!

    //numbers outlet
    @IBOutlet weak var zeroBtn: UIButton!
    @IBOutlet weak var oneBtn: UIButton!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var fiveBtn: UIButton!
    @IBOutlet weak var sixBtn: UIButton!
    @IBOutlet weak var sevenBtn: UIButton!
    @IBOutlet weak var eightBtn: UIButton!
    @IBOutlet weak var nineBtn: UIButton!

    //呈現計算的狀態>>> 是或不是
    var performingMath: Bool = false
    //計算按鈕的點擊次數
    var btnTappedCount: Int  = 0
    //總數的字串
    var equation = ""
    //小數點
    var decimals = false

    var operatorSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up numberLabel.text is "0"
        numberLabel.text = "0"

        //let text could be fix to width
        numberLabel.adjustsFontSizeToFitWidth = true

        //update the btnTargetAction
        updateBtnTargetAction ()
    }

    @IBAction func numberButtonTapped(_ sender: UIButton) {

        if operatorSelected {
                numberLabel.text = ""
                operatorSelected = false
            }

        let numberTag = sender.tag - 1
        //當計算的數字超過第一個是字數時
        if performingMath == true {
            numberLabel.text = String(numberTag)
            performingMath = false

        } else {
            //判斷第一位數是否為"0"
            if numberLabel.text != "0" {
                numberLabel.text! += String(numberTag)
            } else {
                numberLabel.text = ""
                numberLabel.text! += String(numberTag)
            }
        } ; print(numberTag)
    }

    @IBAction func operatorsBtnTapped(_ sender: UIButton) {

        if let inputNum = numberLabel.text {
               let operatorSign: String
               switch sender.tag {
               case 14:
                   operatorSign = "/"
                   print("divide")
               case 15:
                   operatorSign = "*"
                   print("multiply")
               case 16:
                   operatorSign = "-"
                   print("minus")
               case 17:
                   operatorSign = "+"
                   print("plus")
               default:
                   return
               }
               equation = inputNum + operatorSign
               operatorSelected = true
           }
    }

    @IBAction func equalBtnTapped(_ sender: UIButton) {

        if let inputNum = numberLabel.text, !inputNum.isEmpty {
                let cleanInputNum = inputNum.replacingOccurrences(of: ",", with: "")
                equation += cleanInputNum
            }

            // 確保 equation 本身沒有逗號
            equation = equation.replacingOccurrences(of: ",", with: "")

            print("Evaluating equation: \(equation)") // <- 這裡列印equation的內容

            do {
                let result = try equation.evaluate()

                var formattedResult: String
                if result.truncatingRemainder(dividingBy: 1) == 0 {
                    formattedResult = String(format: "%.0f", result)
                } else {
                    formattedResult = String(format: "%.6f", result)
                }

                numberLabel.text = formatToThousandSeparator(formattedResult)

            } catch {
                print("Error evaluating expression: \(error)")
                // 可以在這裡提供用戶錯誤反饋
            }
      }

    func formatToThousandSeparator(_ numberString: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: Double(numberString) ?? 0.0)) ?? ""
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
        performingMath = false
        decimals = false
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
        }; print("btnPlusForwardslashMinusBtnTapped")
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
        }; print("percentageBtnTapped")
    }

    func updateBtnTargetAction () {
        //allClear
        btnAllClear.addTarget(self, action: #selector(updateClearUI), for: .touchDown)
        //plusForwardslashMinus
        btnPlusForwardslashMinus.addTarget(self, action: #selector(updateBtnPlusForwardslashMinusUI), for: .touchDown)
        //percentageBtn
        btnPercentage.addTarget(self, action: #selector(updatePercentageUI), for: .touchDown)
        //divideBtn
        divideBtn.addTarget(self, action: #selector(updateDivideBtnUI), for: .touchDown)
        //multiplyBtn
        multiplyBtn.addTarget(self, action: #selector(updateMultiplyBtnUI), for: .touchDown)
        //minusBtn
        minusBtn.addTarget(self, action: #selector(updateMinusBtnUI), for: .touchDown)
        //plusBtn
        plusBtn.addTarget(self, action: #selector(updatePlusBtnUI), for: .touchDown)
        //equalBtn
        equalBtn.addTarget(self, action: #selector(updateEqualBtnUI), for: .touchDown)
        // number 0
        zeroBtn.addTarget(self, action: #selector(updateZeroBtnUI), for: .touchDown)
        // number 1
        oneBtn.addTarget(self, action: #selector(updateOneBtnUI), for: .touchDown)
        // number 2
        twoBtn.addTarget(self, action: #selector(updateTwoBtnUI), for: .touchDown)
        // number 3
        threeBtn.addTarget(self, action: #selector(updateThreeBtnUI), for: .touchDown)
        // number 4
        fourBtn.addTarget(self, action: #selector(updateFourBtnUI), for: .touchDown)
        // number 5
        fiveBtn.addTarget(self, action: #selector(updateFiveBtnUI), for: .touchDown)
        // number 6
        sixBtn.addTarget(self, action: #selector(updateSixBtnUI), for: .touchDown)
        // number 7
        sevenBtn.addTarget(self, action: #selector(updateSevenBtnUI), for: .touchDown)
        // number 8
        eightBtn.addTarget(self, action: #selector(updateEightBtnUI), for: .touchDown)
        // number 9
        nineBtn.addTarget(self, action: #selector(updateNineBtnUI), for: .touchDown)
        // dotBtn
        dotBtn.addTarget(self, action: #selector(updateDotBtnUI), for: .touchDown)
    }

    //Build the btn Clear's color changing function
    @objc func updateClearUI () {
        btnAllClear.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        if btnAllClear.backgroundColor == UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1) {
            UIView.animate(withDuration: 0.3) {
                self.btnAllClear.backgroundColor = UIColor.lightGray
            }
        }
    }
    //Build the btn PlusForwardslashMinus's color changing function
    @objc func updateBtnPlusForwardslashMinusUI () {
        btnPlusForwardslashMinus.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        if btnPlusForwardslashMinus.backgroundColor == UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1) {
            UIView.animate(withDuration: 0.3) {
                self.btnPlusForwardslashMinus.backgroundColor = UIColor.lightGray
            }
        }
    }
    //Build the btn Percentage's color changing function
    @objc func updatePercentageUI () {
        btnPercentage.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        if btnPercentage.backgroundColor == UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1) {
            UIView.animate(withDuration: 0.3) {
                self.btnPercentage.backgroundColor = UIColor.lightGray
            }
        }
    }
    //建立按鈕Divide的變色功能
    @objc func updateDivideBtnUI () {
        divideBtn.backgroundColor = UIColor.white
        divideBtn.tintColor = UIColor.systemOrange
        if divideBtn.backgroundColor == UIColor.white {
            UIView.animate(withDuration: 0.3) {
                self.divideBtn.backgroundColor = UIColor.systemOrange
                self.divideBtn.tintColor = UIColor.white
            }
        }
    }
    //建立按鈕Multiply的變色功能
    @objc func updateMultiplyBtnUI () {
            multiplyBtn.backgroundColor = UIColor.white
            multiplyBtn.tintColor = UIColor.systemOrange
            if multiplyBtn.backgroundColor == UIColor.white {
                UIView.animate(withDuration: 0.3) {
                    self.multiplyBtn.backgroundColor = UIColor.systemOrange
                    self.multiplyBtn.tintColor = UIColor.white
            }
        }
    }
    //建立按鈕Minus的變色功能
    @objc func updateMinusBtnUI () {
        minusBtn.backgroundColor = UIColor.white
        minusBtn.tintColor = UIColor.systemOrange
        if minusBtn.backgroundColor == UIColor.white {
            UIView.animate(withDuration: 0.3) {
                self.minusBtn.backgroundColor = UIColor.systemOrange
                self.minusBtn.tintColor = UIColor.white
            }
        }
    }
    //建立按鈕Plus的變色功能
    @objc func updatePlusBtnUI () {
        plusBtn.backgroundColor = UIColor.white
        plusBtn.tintColor = UIColor.systemOrange
        if plusBtn.backgroundColor == UIColor.white {
            UIView.animate(withDuration: 0.3) {
                self.plusBtn.backgroundColor = UIColor.systemOrange
                self.plusBtn.tintColor = UIColor.white
            }
        }
    }
    //建立按鈕equal的變色功能
    @objc func updateEqualBtnUI () {
        equalBtn.backgroundColor = UIColor.white
        equalBtn.tintColor = UIColor.systemOrange
        if equalBtn.backgroundColor == UIColor.white {
            UIView.animate(withDuration: 0.3) {
                self.equalBtn.backgroundColor = UIColor.systemOrange
                self.equalBtn.tintColor = UIColor.white
            }
        }
    }
    //建立按鈕0的變色功能
    @objc func updateZeroBtnUI () {
        zeroBtn.backgroundColor = UIColor.lightGray
        if zeroBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.zeroBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕1的變色功能
    @objc func updateOneBtnUI () {
        oneBtn.backgroundColor = UIColor.lightGray
        if oneBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.oneBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕2的變色功能
    @objc func updateTwoBtnUI () {
        twoBtn.backgroundColor = UIColor.lightGray
        if twoBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.twoBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕3的變色功能
    @objc func updateThreeBtnUI () {
        threeBtn.backgroundColor = UIColor.lightGray
        if threeBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.threeBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕4的變色功能
    @objc func updateFourBtnUI () {
        fourBtn.backgroundColor = UIColor.lightGray
        if fourBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.fourBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕5的變色功能
    @objc func updateFiveBtnUI () {
        fiveBtn.backgroundColor = UIColor.lightGray
        if fiveBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.fiveBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕6的變色功能
    @objc func updateSixBtnUI () {
        sixBtn.backgroundColor = UIColor.lightGray
        if sixBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.sixBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕7的變色功能
    @objc func updateSevenBtnUI () {
        sevenBtn.backgroundColor = UIColor.lightGray
        if sevenBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.sevenBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕8的變色功能
    @objc func updateEightBtnUI () {
        eightBtn.backgroundColor = UIColor.lightGray
        if eightBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.eightBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕9的變色功能
    @objc func updateNineBtnUI () {
        nineBtn.backgroundColor = UIColor.lightGray
        if nineBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.nineBtn.backgroundColor = UIColor.darkGray
            }
        }
    }
    //建立按鈕dot的變色功能
    @objc func updateDotBtnUI () {
        dotBtn.backgroundColor = UIColor.lightGray
        if dotBtn.backgroundColor == UIColor.lightGray {
            UIView.animate(withDuration: 0.3) {
                self.dotBtn.backgroundColor = UIColor.darkGray
            }
        }
    }

}
