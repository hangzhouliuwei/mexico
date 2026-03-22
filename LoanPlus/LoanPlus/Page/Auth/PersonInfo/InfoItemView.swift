//
//  InfoItemView.swift
//  LoanPlus
//
//  Created by hao on 2024/12/3.
//

import UIKit

class InfoItemView: UIView, UITextFieldDelegate {
    var changeBlock:JsonBlock?
    var info = JSON()
    var nameText = UITextField()
    var inputType = ""
    var cate = ""
    var value = ""
    var code = ""
    var noteList = JSON()
    var emailView = UIView()
    func config(info:JSON) {
        self.info = info
        inputType = info["lwKxwjrTvjqGoWIbsolD"].stringValue
        cate = info["juxlaxazTTMIuJcChKkEFc"].stringValue
        value = info["DtdjYPPNFBqrfkqM"].stringValue
        code = info["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].stringValue
        noteList = info["tRgdyTXKVIliMaJOtxuOHYvRQUJHsV"]
        
        let nameTitle = UILabel(frame: CGRect(x: 0, y: 12, width: self.width, height: 17))
        nameTitle.textColor = UIColor(hex: 0x67728A)
        nameTitle.font = .systemFont(ofSize: 13)
        nameTitle.text = info["mKsoYNXaLHQHofdNQlnVFTaLyD"].stringValue
        self.addSubview(nameTitle)
                
        nameText.frame = CGRect(x: 0, y: nameTitle.bottom + 12, width: self.width, height: 48)
        nameText.placeholder = info["uaKsiOaZKvbtyvkpWfvelhwfbBy"].stringValue
        nameText.textColor = .init(hex: 0x0B1A3C)
        nameText.backgroundColor = .init(hex: 0xF6F8FA)
        nameText.font = .systemFont(ofSize: 13)
        nameText.keyboardType = .default
        nameText.delegate = self
        nameText.cornerRadius = 4
        nameText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 48))
        nameText.leftViewMode = .always
        nameText.clearButtonMode = .never
        nameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nameText.isEnabled = (cate == "rap")
        if cate != "rap" {
            let btn = UIButton(frame: nameText.frame)
            btn.addTap { [weak self] in
                self?.showAlert()
            }
            self.addSubview(btn)
        }
        self.addSubview(nameText)
        
        let icon = UIButton(type: .custom)
        icon.isUserInteractionEnabled = false
        icon.frame = CGRect(x: nameText.width - nameText.height, y: 0, width: nameText.height, height: nameText.height)
        icon.setImage(UIImage(named: "cert_select_icon"), for: .normal)
        icon.isHidden = (cate == "rap")
        nameText.addSubview(icon)
                
        if code == "FqFcpFNNmliPkqXDsBp" {
            emailView.frame = CGRect(x: 0, y: self.height + 5, width: self.width, height: 160)
            emailView.isHidden = true
            emailView.backgroundColor = .white
            emailView.cornerRadius = 12
            emailView.addShadow(color: .black, opacity: 0.1, radius: 4, offset: CGSize(width: 0, height: 0))
            self.addSubview(emailView)
        }
        refreshValue()
    }
    
    func refreshValue() {
        value = info["DtdjYPPNFBqrfkqM"].stringValue
        if (cate == "rap" || cate == "rfp"){
            nameText.text = value
            return
        }
        let noteList = info["tRgdyTXKVIliMaJOtxuOHYvRQUJHsV"].arrayValue
        for item in noteList {
            let type = item["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue
            let name = item["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
            if value == type {
                nameText.text = name
            }
        }
    }
    
    func showAlert() {
        self.superview?.endEditing(true)
        if cate == "rfp" {
            let alert = DateAlert(date: value)
            alert.show()
            alert.selectBlock = { [weak self] result in
                self?.info["DtdjYPPNFBqrfkqM"].stringValue = result
                self?.refreshValue()
                self?.callBack()
                self?.checkNext()
            }
            return
        }
        let alertView = SingleSelectView(dataList: noteList, defaulValue: value)
        UIApplication.shared.windows.first?.addSubview(alertView)
        alertView.clickBlock = { [weak self] str in
            self?.info["DtdjYPPNFBqrfkqM"].stringValue = str
            self?.refreshValue()
            self?.callBack()
            self?.checkNext()
        }
    }
    
    func checkNext() {
        if let infoViews = self.superview?.subviews {
            for subview in infoViews {
                if let infoView = subview as? InfoItemView {
                    if infoView.value.isEmpty && infoView.cate != "rap" && (infoView.tag == self.tag + 1) {
                        infoView.showAlert()
                    }
                }
            }
        }
    }
    
    func callBack() {
        changeBlock?(info)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = nameText.text ?? ""
        info["DtdjYPPNFBqrfkqM"].stringValue = text
        callBack()
        if code == "FqFcpFNNmliPkqXDsBp" {
            refreshEmailList(with: text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (textField.text?.count ?? 0) + string.count - range.length <= 100
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if code == "FqFcpFNNmliPkqXDsBp" {
            let text = nameText.text ?? ""
            refreshEmailList(with: text)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if code == "FqFcpFNNmliPkqXDsBp" {
            emailView.isHidden = true
        }
    }

    func refreshEmailList(with text: String) {
        if text.isEmpty {
            emailView.isHidden = true
            return
        }
        emailView.isHidden = false
        emailView.removeAllSubviews()
        
        let leadArr = text.split(separator: "@").map { String($0) }
        let emailArr = ["@gmail.com", "@hotmail.com", "@outlook.com", "@live.com.mx"]
        var validArr: [String] = []
        
        if leadArr.count == 1 {
            validArr = emailArr
        } else if leadArr.count == 2 {
            validArr = emailArr.filter { $0.hasPrefix("@\(leadArr[1])") }
        } else {
            emailView.isHidden = true
            return
        }
        
        if validArr.isEmpty {
            emailView.isHidden = true
            return
        }
        
        for (index, email) in validArr.enumerated() {
            let content = leadArr[0] + email
            let emailButton = UIButton(type: .custom)
            emailButton.contentHorizontalAlignment = .left
            emailButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            emailButton.frame = CGRect(x: 15, y: index * 40, width: emailView.width - 30, height: 40)
            emailButton.setTitle(content, for: .normal)
            emailButton.setTitleColor(.lightGray, for: .normal)
            emailView.addSubview(emailButton)
            emailButton.addTap { [weak self] in
                self?.emailClick(content)
            }
        }
    }

    func emailClick(_ content:String) {
        info["DtdjYPPNFBqrfkqM"].stringValue = content
        refreshValue()
        callBack()
        endEditing(true)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in self.subviews.reversed() {
            let convertedPoint = subview.convert(point, from: self)
            if let hitView = subview.hitTest(convertedPoint, with: event) {
                return hitView
            }
        }
        return super.hitTest(point, with: event)
    }
}
