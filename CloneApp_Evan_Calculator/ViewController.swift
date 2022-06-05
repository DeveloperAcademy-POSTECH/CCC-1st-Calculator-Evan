//
//  ViewController.swift
//  CloneApp_Evan_Calculator
//
//  Created by 김예훈 on 2022/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    var buttons: [CalculatorButton] = []
    var stacks: [UIStackView] = []
    
    var expression = ""
    var nowOperand: String = "0" {
        didSet {
            self.label.text = nowOperand
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appendButtons()
        self.addButtonToView()
        self.addLabelToView()
    }
}

extension ViewController {
   
    private func appendButtons() {
        for _ in 0..<5 {
            stacks.append(UIStackView(arrangedSubviews: []))
        }
        
        for i in 0...9 {
            let button = CalculatorButton(type: .operand(type: .number(value: i)))
            button.addTarget(self, action: #selector(tapNum(_:)), for: .touchUpInside)
            buttons.append(button)
            if i == 0 {
                stacks[0].addArrangedSubview(button)
            } else {
                stacks[(i-1)/3+1].addArrangedSubview(button)
            }
        }
        
        let dotButton = CalculatorButton(type: .operand(type: .dot))
        dotButton.addTarget(self, action: #selector(tapDot(_:)), for: .touchUpInside)
        buttons.append(dotButton)
        stacks[0].addArrangedSubview(dotButton)

        for subType in SubType.allCases {
            let button = CalculatorButton(type: .sub(type: subType))
            switch subType {
            case .changeSign:
                button.addTarget(self, action: #selector(tapChangeSign(_:)), for: .touchUpInside)
            case .percent:
                button.addTarget(self, action: #selector(tapPercent(_:)), for: .touchUpInside)
            case .clear:
                button.addTarget(self, action: #selector(tapClear(_:)), for: .touchUpInside)
            }
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
    
    private func addLabelToView() {
        self.label.textColor = .white
        self.label.font = .systemFont(ofSize: 92, weight: .light)
        self.label.text = "0"
        self.label.textAlignment = .right
        view.addSubview(self.label)
        
        let margins = view.layoutMarginsGuide
        label.translatesAutoresizingMaskIntoConstraints = false
        label.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: stacks.last!.topAnchor, constant: -16).isActive = true
    }
}

extension ViewController {
    @objc private func tapNum(_ sender: UIButton) {
        guard let value = sender.titleLabel?.text else { return }
        if nowOperand == "0" {
            nowOperand = value
        } else {
            nowOperand += value
        }
    }
    
    @objc private func tapDot(_ sender: UIButton) {
        guard nowOperand.firstIndex(of: ".") == nil else { return }
        nowOperand += "."
    }
    
    @objc private func tapChangeSign(_ sender: UIButton) {
        guard let value = nowOperand.first else { return }
        if String(value) == "-" {
            nowOperand.remove(at: nowOperand.startIndex)
        } else {
            nowOperand = "-" + nowOperand
        }
    }
    
    @objc private func tapPercent(_ sender: UIButton) {
        guard let value = Double(nowOperand) else { return }
        nowOperand = String(value * 0.01)
    }
    
    @objc private func tapClear(_ sender: UIButton) {
        nowOperand = "0"
    }
}


