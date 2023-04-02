//
//  MultipleChoiceWithTextView.swift
//  SandwichApp
//
//  Created by Hilmy Veradin on 07/10/22.
//

import Foundation
import UIKit

final class MultipleChoiceWithTextView: UIView {
    
    // MARK: - PROPERTIES
    // MARK: UI
    private lazy var reasonLabel: UILabel = {
        let label = UILabel()
        label.text = "Your reason"
        label.backgroundColor = .red
        return label
    }()
    
    private lazy var characterCount: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "100/100"
        return label
    }()
    
//    lazy var height = 50
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .blue
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.keyboardType = UIKeyboardType.default
        textView.returnKeyType = UIReturnKeyType.done
        textView.delegate = self
        return textView
    }()
    
    // MARK: DATA
    private var baseMultipleChoiceView: UIView!
    private var textArray: [String]!
    
    // MARK: - INITIALIZATION
    
    init(textArray: [String]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.textArray = textArray
        self.baseMultipleChoiceView = BaseMulitpleChoiceView(textArray: textArray, cellSpacing: 10)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS
    // MARK: PRIVATE
    private func setupView() {
        // Arrange base multiple choice view
        self.addSubview(baseMultipleChoiceView)
        baseMultipleChoiceView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        // Arrange stackview
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(reasonLabel)
        stackView.addArrangedSubview(characterCount)
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(baseMultipleChoiceView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(500)
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - TEXTFIELD EXTENSIONS
extension MultipleChoiceWithTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 200
    }
    
    //MARK: PRIVATE
    private func updateCharacterCount() {
       let summaryCount = self.textView.text.count
       self.characterCount.text = "\((0) + summaryCount)/200"
    }
}
