//
//  CardInfoAlertVC.swift
//  LoanPlus
//
//  Created by hao on 2024/12/2.
//

import UIKit
import IQKeyboardManagerSwift

class CardInfoAlertVC: BaseVC, UITextFieldDelegate{
    var cardName = ""
    var cardNumber = ""
    var productId = ""
    var onDismiss: DicBlock?
    var onCancel: VoidBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        //IQKeyboardManager.shared.enable = true
        setupUI()
    }
    func setupUI() {
        contentView.isScrollEnabled = true
        contentView.backgroundColor = .clear
        contentView.contentSize = CGSizeMake(ScreenWidth, contentView.height + 1)
        view.backgroundColor = .black.alpha(value: 0.5)
        let alert = UIView(frame: CGRect(x:0, y: 0, width: ScreenWidth - 75.w, height: 446.w))
        alert.backgroundColor = .white
        alert.cornerRadius = 16
        alert.centerX = ScreenWidth/2
        alert.centerY = ScreenHeight/2
        contentView.addSubview(alert)
        
        let close = UIButton(type: .custom)
        close.frame = CGRect(x: alert.width - 44, y: 0, width: 44, height: 44)
        close.setImage(UIImage(named: "info_alert_close"), for: .normal)
        alert.addSubview(close)
        close.addTap { [weak self] in
            self?.onCancel?()
            self?.dismiss(animated: false)
        }
        
        let title = UILabel(frame: CGRect(x: 0, y: 30.w, width: alert.width, height: 28))
        title.textColor = .init(hex: 0x0B1A3C)
        title.font = .font(18)
        title.textAlignment = .center
        title.text = "Información de identificación"
        alert.addSubview(title)
        
        let nameDesc = UILabel(frame: CGRect(x: 15, y: 79.w, width: alert.width, height: 20))
        nameDesc.textColor = .init(hex: 0x081238)
        nameDesc.font = .font(14)
        nameDesc.text = "ID Name"
        alert.addSubview(nameDesc)
        
        let nameText = UITextField(frame: CGRect(x: 15, y: 108.w, width: alert.width - 30, height: 53))
        nameText.tag = 1
        nameText.text = cardName
        nameText.textColor = .black
        nameText.backgroundColor = .white
        nameText.font = .fontMedium(17)
        nameText.keyboardType = .default
        nameText.delegate = self
        nameText.addBorder()
        nameText.cornerRadius = 8
        nameText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 53))
        nameText.leftViewMode = .always
        nameText.clearButtonMode = .never
        nameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        alert.addSubview(nameText)
        
        let idDesc = UILabel(frame: CGRect(x: 15, y: 172.w, width: alert.width, height: 20))
        idDesc.textColor = .init(hex: 0x081238)
        idDesc.font = .font(14)
        idDesc.text = "ID Number"
        alert.addSubview(idDesc)
        
        let idValue = UILabel(frame: CGRect(x: 15, y: 201.w, width: alert.width, height: 25))
        idValue.textColor = .init(hex: 0x081238)
        idValue.font = .fontMedium(17)
        idValue.text = cardNumber
        alert.addSubview(idValue)
        
        let idInfo = UILabel(frame: CGRect(x: 15, y: 239.w, width: alert.width - 30, height: 20))
        idInfo.textColor = .init(hex: 0x081238)
        idInfo.font = .font(12)
        idInfo.numberOfLines = 0
        idInfo.text = "Verifique que la información de identifcación proporcionada sea correcta, una vez enviada nopodrá ser modificada"
        idInfo.sizeToFit()
        idInfo.setLineSpace(5, text: idInfo.text ?? "")
        alert.addSubview(idInfo)
        
        let idText = UITextField(frame: CGRect(x: 15, y: 299.w, width: alert.width - 30, height: 53))
        idText.tag = 2
        idText.text = cardNumber
        idText.textColor = .black
        idText.backgroundColor = .white
        idText.font = .fontMedium(17)
        idText.keyboardType = .default
        idText.delegate = self
        idText.addBorder()
        idText.cornerRadius = 8
        idText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 53))
        idText.leftViewMode = .always
        idText.clearButtonMode = .never
        idText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        alert.addSubview(idText)
        
        let confirm = MxButton(type: .custom)
        confirm.config(frame: CGRect(x: 20.w, y: alert.height - 78.w, width: alert.width - 40.w, height: 50.w), title: "Confirmar")
        alert.addSubview(confirm)
        confirm.addTap { [weak self] in
            self?.updateInfo()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 1 {
            cardName = textField.text ?? ""
        }else  if textField.tag == 2 {
            cardNumber = textField.text ?? ""
        }
    }

    func updateInfo() {
        if cardName.isEmpty || cardNumber.isEmpty {
            return
        }
        let dic = [
            "NnfawhNtmBUUfabHrKnvuPhg":cardName,
            "QPDrgoFQtBMHUPoASGQTsyN": cardNumber,
            "MxpNpYKadDRvmjqybUjsIEARDwIwW":"11",
            "yPIpfzncLDuktqTgNlFIuOLsjr":productId,
            "tolYUlUNvZkgCrAdX":"sda"
        ]
        Network.post(path: .publicSave, parameters: dic, loading: true) { [weak self] res, error in
            if res.success {
                self?.onDismiss?(["name":self?.cardName ?? "", "number":self?.cardNumber ?? ""])
                self?.dismiss(animated: false)
            }
        }
    }
}
