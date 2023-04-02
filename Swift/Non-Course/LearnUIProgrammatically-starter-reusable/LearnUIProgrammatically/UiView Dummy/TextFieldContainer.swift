//
//  TextFieldContainer.swift
//  SandwichApp
//
//  Created by Renzo Alvaroshan on 09/10/22.
//

import UIKit
import SnapKit

class TextFieldContainer: UIView {
    
    let header: String?
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = header
        return label
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        return tf
    }()
    
    init(header: String?, placeHolder: String?) {
        self.header = header
        super.init(frame: .zero)
        self.textField.placeholder = placeHolder
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(borderView)
        self.addSubview(textField)
        self.addSubview(headerLabel)
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(textField).offset(-8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(borderView)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(borderView.snp.top).offset(-8)
            make.leading.equalTo(self.snp.leading)
        }
    }
}
