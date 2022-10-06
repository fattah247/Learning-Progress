//
//  ReusableButton.swift
//  LearnUIProgrammatically
//
//  Created by Muhammad Abdul Fattah on 06/10/22.
//

import UIKit

class ReusableButton: UIButton {
  
  enum buttonTypeEnum {
    case axeButton
    case gunButton
  }
  
  public private(set) var clickButtonType: buttonTypeEnum
  public private(set) var buttonText: String
  
  private func configureButtonStyle() {
    switch clickButtonType {
    case .axeButton:
      self.backgroundColor = .blue
    case .gunButton:
      self.backgroundColor = .red
    }
    self.layer.cornerRadius = 5
    self.tintColor = .white
    self.clipsToBounds = true
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  init(buttonTitle: String, clickButtonType: buttonTypeEnum) {
   
    self.buttonText = buttonTitle
    self.clickButtonType = clickButtonType
      super.init(frame: .zero)
      self.configureButton()
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  private func configureButton() {
    self.setTitle(buttonText, for: .normal)
    self.configureButtonStyle()
  }
}
