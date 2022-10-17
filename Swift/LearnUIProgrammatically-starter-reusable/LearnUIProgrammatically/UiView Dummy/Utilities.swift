//
//  Utilities.swift
//  SandwichApp
//
//  Created by Renzo Alvaroshan on 29/09/22.
//

import UIKit
import SnapKit

class Utilities {

    func inputContainerView(textField: UITextField) -> UIView {
        let view = UIView()
        // view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.right.equalToSuperview()
        }

        let dividerView = UIView()
        dividerView.backgroundColor = .black
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.75)
        }

        return view
    }

    func standardButton(text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        return button
    }

    func attributedButton(_ text: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: text,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor: UIColor.systemBlue,
                                                                     .underlineStyle: NSUnderlineStyle.single.rawValue])

        button.setAttributedTitle(attributedTitle, for: .normal)

        return button
    }
}
