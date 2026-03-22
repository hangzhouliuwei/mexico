//
//  PhoneNoInputView.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/26.
//

import UIKit

class PhoneNoInputView: UIView , UITextFieldDelegate {

    private lazy var preLabel: UILabel = {
           let label = UILabel(frame: CGRect(x: 20, y: 12, width: 48, height: 28))
           label.center.y = self.frame.height / 2
           label.backgroundColor = UIColor(hex: "#EAF0FD")
           label.text = "+52"
           label.textColor = UIColor(hex: "#67728A")
           label.font = UIFont.boldSystemFont(ofSize: 17)
           label.textAlignment = .center
           self.addSubview(label)
           return label
       }()
       
       private lazy var textView: UITextField = {
           let textField = UITextField(frame: CGRect(x: preLabel.frame.maxX + 10,
                                                     y: 0,
                                                     width: self.frame.width - preLabel.frame.maxX - 22,
                                                     height: self.frame.height))
           textField.center.y = self.frame.height / 2
           textField.borderStyle = .none
           textField.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
           textField.textColor = .black
           textField.textAlignment = .left
           textField.contentVerticalAlignment = .center
           textField.clearButtonMode = .whileEditing
           textField.attributedPlaceholder = NSAttributedString(string: "Nomor Telepon",
                                                                 attributes: [
                                                                    .font: UIFont.boldSystemFont(ofSize: 16),
                                                                   .foregroundColor: UIColor(hex: "#0B1A3C") ?? .white
                                                                 ])
           textField.keyboardType = .numberPad
           textField.delegate = self
           return textField
       }()
       
       var text: String {
           get { textView.text ?? "" }
           set { textView.text = newValue }
       }
       
       var inputBlock: ((Int) -> Void)?
       
       // MARK: - Initializer
       override init(frame: CGRect) {
           super.init(frame: frame)
           self.backgroundColor = UIColor(named: "MainBgColor") // 替换为你的颜色
           reloadUI()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func reloadUI() {
           addSubview(preLabel)
           addSubview(textView)
           let lineView = UIView(frame: CGRect(x: 20, y: self.height, width: Int(self.width) - 40 , height: 1))
           lineView.backgroundColor = UIColor(hex: "#B1B9C9")
           addSubview(lineView)
       }
       
       // MARK: - UITextFieldDelegate
       func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           // PBCommonManager.requestZhuCeMaiDian("21", phoneStr: "")
           return true
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           // PBCommonManager.requestZhuCeMaiDian("30", phoneStr: "")
       }
       
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           guard isAllNum(string) else { return false }
           
           var text = textField.text ?? ""
           let characterSet = CharacterSet(charactersIn: "0123456789")
           
           // Remove spaces and validate characters
           let sanitizedString = string.replacingOccurrences(of: " ", with: "")
           if sanitizedString.rangeOfCharacter(from: characterSet.inverted) != nil {
               return false
           }
           text = (text as NSString).replacingCharacters(in: range, with: sanitizedString)
           text = text.replacingOccurrences(of: " ", with: "")
           
           // Format the text
           var formattedText = ""
           while !text.isEmpty {
               let substring = String(text.prefix(4))
               formattedText += substring
               if substring.count == 4 { formattedText += " " }
               text = String(text.dropFirst(4))
           }
           
           formattedText = formattedText.trimmingCharacters(in: characterSet.inverted)
           if formattedText.count > 18 {
               return false
           }
           textField.text = formattedText
           
           inputBlock?(formattedText.count)
           return false
       }
       
       private func isAllNum(_ string: String) -> Bool {
           for char in string {
               if !char.isNumber { return false }
           }
           return true
       }
       
       func becomeFirstResponder() {
           textView.becomeFirstResponder()
       }

}
