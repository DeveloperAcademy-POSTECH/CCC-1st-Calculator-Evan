//
//  ViewController.swift
//  CloneApp_Evan_Calculator
//
//  Created by 김예훈 on 2022/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    var buttons: [CalculatorButton] = []
    
    var stacks: [UIStackView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appendButtons()
        self.addButtonToView()
    }
}

extension ViewController {
    private func appendButtons() {
        
        for _ in 0..<5 {
            stacks.append(UIStackView(arrangedSubviews: []))
        }
        
        for i in 0...9 {
            let button = CalculatorButton(type: .operand(type: .number(value: i)))
            buttons.append(button)
            if i == 0 {
                stacks[0].addArrangedSubview(button)
            } else {
                stacks[(i-1)/3+1].addArrangedSubview(button)
            }
        }
        
        let dotButton = CalculatorButton(type: .operand(type: .dot))
        buttons.append(dotButton)
        stacks[0].addArrangedSubview(dotButton)

        for subType in SubType.allCases {
            let button = CalculatorButton(type: .sub(type: subType))
            buttons.append(button)
            stacks[4].addArrangedSubview(button)
        }

        for (index, operatorType) in zip(0...4, OperatorType.allCases) {
            let button = CalculatorButton(type: .basicOperator(type: operatorType))
            buttons.append(button)
            stacks[4-index].addArrangedSubview(button)
        }
    }
    
    private func addButtonToView() {
        
        let margins = view.layoutMarginsGuide
        
        for i in stacks.indices {
            self.view.addSubview(stacks[i])
            stacks[i].spacing = 16
            stacks[i].axis = .horizontal
            stacks[i].translatesAutoresizingMaskIntoConstraints = false
            stacks[i].leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            stacks[i].trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            
            if i == 0 {
                stacks[i].bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -40).isActive = true
            } else {
                stacks[i].bottomAnchor.constraint(equalTo: stacks[i-1].topAnchor, constant: -16).isActive = true
            }
        }
    }
}


