//
//  ReusableLabel.swift
//  LearnUIProgrammatically
//
//  Created by Muhammad Abdul Fattah on 06/10/22.
//

import UIKit

class ReusableLabel: UILabel {
  
  enum labelTypeEnum {
    case title
    case subtitle
  }
  
  public private(set) var labelType: labelTypeEnum
  public private(set) var labelText: String
  
  private func configureLabelStyle() {
      
      // Will be executed only when a certain case is chosen
      switch labelType {
          case .title:
              self.font = .boldSystemFont(ofSize: 24)
              self.textColor = .black
          case .subtitle:
              self.font = .systemFont(ofSize: 16)
              self.textColor = .gray
      }
      
      // Will be executed all the time
      self.translatesAutoresizingMaskIntoConstraints = false
      self.numberOfLines = 0
      self.textAlignment = .left
  }
  
  init(labelText: String, labelType: labelTypeEnum) {
      /// Safety check 1 “A designated initializer must ensure that all of the “properties introduced by its class are initialized before it delegates up to a superclass initializer.”
      self.labelText = labelText
      self.labelType = labelType

      super.init(frame: .zero)
      self.configureLabel()
  }
  
  // This is required to initialize
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // This is the setup default standard properties
  private func configureLabel() {

      self.text = labelText
      self.configureLabelStyle()
  }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
