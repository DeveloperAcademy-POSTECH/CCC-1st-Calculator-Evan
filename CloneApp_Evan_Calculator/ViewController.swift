//
//  ViewController.swift
//  CloneApp_Evan_Calculator
//
//  Created by 김예훈 on 2022/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    var buttons: [CalculatorButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appendButtons()
    }
}

extension ViewController {
    private func appendButtons() {
        
        for i in 0...9 {
            buttons.append( CalculatorButton(type: .operand(type: .number(value: i))) )
        }
        
        buttons.append( CalculatorButton(type: .operand(type: .dot)) )
        
        for operatorType in OperatorType.allCases {
            buttons.append( CalculatorButton(type: .basicOperator(type: operatorType)) )
        }
        
        for subType in SubType.allCases {
            buttons.append( CalculatorButton(type: .sub(type: subType)) )
        }
    }
}


