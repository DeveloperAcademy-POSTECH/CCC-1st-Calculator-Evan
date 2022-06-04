//
//  CalculatorButton.swift
//  CloneApp_Evan_Calculator
//
//  Created by 김예훈 on 2022/06/04.
//

import UIKit

enum CalculatorButtonType {
    case operand(type: OperandType)
    case basicOperator(type: OperatorType)
    case sub(type: SubType)
}

enum OperandType {
    case number(value: Int)
    case dot
}

enum OperatorType: CaseIterable {
    case divide
    case multiply
    case minus
    case plus
    case equal
    
    var systemName: String {
        switch self {
        case .plus:
            return "plus"
        case .minus:
            return "minus"
        case .divide:
            return "divide"
        case .multiply:
            return "multiply"
        case .equal:
            return "equal"
        }
    }
}

enum SubType: CaseIterable {
    case clear
    case changeSign
    case percent
    
    var systemName: String {
        switch self {
        case .clear:
            return ""
        case .changeSign:
            return "plus.forwardslash.minus"
        case .percent:
            return "percent"
        }
    }
}


class CalculatorButton: UIButton {
    
    var calculatorType: CalculatorButtonType = .operand(type: .number(value: 0))

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(type: CalculatorButtonType) {
        self.calculatorType = type
        super.init(frame: .zero)
        self.setup()
    }
    
    private func setup() {
        
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .darkGray
        
        switch calculatorType {
        
        case .operand(let type):
            if case let .number(value) = type {
                self.setTitle(String(value), for: .normal)
                config.baseBackgroundColor = .darkGray
            } else {
                self.setTitle(".", for: .normal)
            }
            
        case .basicOperator(let type):
            self.setImage(UIImage(systemName: type.systemName), for: .normal)
            config.baseBackgroundColor = .systemOrange
            
        case .sub(let type):
            if case .clear = type {
                self.setTitle("AC", for: .normal)
            } else {
                self.setImage(UIImage(systemName: type.systemName), for: .normal)
            }
            config.baseBackgroundColor = .lightGray
            
        }
        
        self.configuration = config
        translatesAutoresizingMaskIntoConstraints = false
        
        if case .operand(.number(0)) = calculatorType {
        } else {
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        }
        
    }
}

