//
//  BankInfoVC.swift
//  LoanPlus
//
//  Created by Kiven on 2024/11/29.
//

import UIKit

class BankInfoVC: CertBaseVC, UITextFieldDelegate {
    
    var dataSource = JSON()
    
    var typeList = JSON()
    var bankList = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        loadData()
    }
    
    //MARK: - loadData
    func loadData(){
        let params:[String:Any] = ["weFhdKNVhVVAAczmVVwiHW":UserM.phone,"yPIpfzncLDuktqTgNlFIuOLsjr":productId]
        Network.post(path: .bankGet, parameters: params,loading: true) { res, error in
            self.dataSource = res.data["JamHxgHiTYxClKqWjuvfkXlPLn"]
            self.dealWithData()
        }
        
    }
    
    //MARK: - loadUI
    func loadUI(){
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview()
            make.height.equalTo(378)
        }
        
        let icon = UIImageView()
        icon.image = UIImage(named: "cert_bank_icon1")
        bgView.addSubview(icon)
        let titleLab = UILabel.create(text: "Los datos de su tarjeta serán usados para el depósito solamente", textColor: .textBlack, font: .fontBold(14))
        titleLab.numberOfLines = 0
        bgView.addSubview(titleLab)
        let lineView = UIView()
        lineView.backgroundColor = .lineGray
        bgView.addSubview(lineView)
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(23)
            make.size.equalTo(CGSize(width: 25.58, height: 24.03))
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(6)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(icon)
            make.height.equalTo(36)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(23)
            make.right.left.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
        
        let typeTitleLab = UILabel.create(text: "Elige tu tipo de cuenta", textColor: .cellTitle, font: .font(13))
        let bankTitleLab = UILabel.create(text: "Banco", textColor: .cellTitle, font: .font(13))
        bgView.addSubview(typeTitleLab)
        bgView.addSubview(bankTitleLab)
        bgView.addSubview(accountLab)
        let typeView = inputVIew(tag: 0)
        let bankView = inputVIew(tag: 1)
        let accountView = inputVIew(tag: 2,addTap: false)
        bgView.addSubview(typeView)
        bgView.addSubview(bankView)
        bgView.addSubview(accountView)
        
        typeTitleLab.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(11)
            make.right.left.equalToSuperview().inset(15)
            make.height.equalTo(17)
        }
        typeView.snp.makeConstraints { make in
            make.top.equalTo(typeTitleLab.snp.bottom).offset(12)
            make.right.left.equalToSuperview().inset(15)
            make.height.equalTo(48)
        }
        
        bankTitleLab.snp.makeConstraints { make in
            make.top.equalTo(typeView.snp.bottom).offset(12)
            make.right.left.equalToSuperview().inset(15)
            make.height.equalTo(17)
        }
        bankView.snp.makeConstraints { make in
            make.top.equalTo(bankTitleLab.snp.bottom).offset(12)
            make.right.left.equalToSuperview().inset(15)
            make.height.equalTo(48)
        }
        
        accountLab.snp.makeConstraints { make in
            make.top.equalTo(bankView.snp.bottom).offset(12)
            make.right.left.equalToSuperview().inset(15)
            make.height.equalTo(17)
        }
        accountView.snp.makeConstraints { make in
            make.top.equalTo(accountLab.snp.bottom).offset(12)
            make.right.left.equalToSuperview().inset(15)
            make.height.equalTo(48)
        }
        
        typeView.addSubview(typeLab)
        bankView.addSubview(bankLab)
        accountView.addSubview(accountFiled)
        accountView.addSubview(questBtn)
        typeLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-40)
        }
        bankLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-40)
        }
        accountFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-40)
        }
        questBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
    }
    
    private lazy var bgView:UIView = {
        let bgView = UIView()
        bgView.cornerRadius = 12
        bgView.backgroundColor = .white
        return bgView
    }()
    
    func inputVIew(tag:Int,addTap:Bool = true) ->UIView{
        let inputVIew = UIView()
        inputVIew.backgroundColor = UIColor(r: 246, g: 248, b: 250)
        inputVIew.cornerRadius = 4
        inputVIew.tag = tag
        if addTap{
            let icons = UIImageView()
            icons.image = UIImage(named: "cert_select_icon")
            inputVIew.addSubview(icons)
            icons.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-12)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 22, height: 22))
            }
            
            let tpas = UITapGestureRecognizer(target: self, action: #selector(inputCLick(_:)))
            inputVIew.isUserInteractionEnabled = true
            inputVIew.addGestureRecognizer(tpas)
        }
        
        return inputVIew
    }
    
    private lazy var typeLab:UILabel = {
        let typeLab = UILabel.create(text: "", textColor: .textBlack, font: .fontMedium(13))
        
        return typeLab
    }()
    
    private lazy var bankLab:UILabel = {
        let bankLab = UILabel.create(text: "", textColor: .textBlack, font: .fontMedium(13))
        
        return bankLab
    }()
    
    private lazy var accountLab:UILabel = {
        let accountLab = UILabel.create(text: "Tarjeta de débito(16-Dígitos)", textColor: .cellTitle, font: .font(13))
        return accountLab
    }()
    
    lazy var accountFiled:UITextField = {
        let accountFiled = UITextField()
        accountFiled.textColor = .textBlack
        accountFiled.backgroundColor = .clear
        accountFiled.font = .fontMedium(13)
        accountFiled.keyboardType = .numberPad
        accountFiled.delegate = self
        
        return accountFiled
    }()
    
    lazy var questBtn:UIButton = {
        let questBtn = UIButton(type: .custom)
        questBtn.setImage(UIImage(named: "cert_quest"), for: .normal)
        questBtn.addTarget(self, action: #selector(questClick), for: .touchUpInside)
        questBtn.isHidden = true
        return questBtn
    }()
    
    
    //MARK: - UITextFieldDelegate
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let txt = textField.text ?? ""
        let digitsOnly = txt.replacingOccurrences(of: "-", with: "")
        
        var maxCount = 16
        if let typeStr = typeLab.text,typeStr.contains("CLABE"){
            maxCount = 18
        }
        if digitsOnly.count > maxCount {
            textField.text = formatWithHyphens(String(digitsOnly.prefix(maxCount)))
        } else {
            textField.text = formatWithHyphens(digitsOnly)
        }
        
    }
    
    private func formatWithHyphens(_ digits: String) -> String {
        var formatted = ""
        for (index, character) in digits.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted.append("-")
            }
            formatted.append(character)
        }
        return formatted
    }
    
    //MARK: - inputCLick
    @objc private func inputCLick(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
        let tags = gesture.view?.tag ?? 0
        var listData = JSON()
        let defaultValue = self.dataSource[tags+1]["DtdjYPPNFBqrfkqM"].stringValue
        if tags == 0{
            listData = typeList
        }else{
            listData = bankList
        }
        let alertView = SingleSelectView(dataList: listData, defaulValue: defaultValue)
        UIApplication.shared.windows.first?.addSubview(alertView)
        alertView.clickBlock = { str in
            self.dataSource[tags+1]["DtdjYPPNFBqrfkqM"].stringValue = str
            self.dealWithData(changeNum: tags == 0)
        }
        
    }
    
    //MARK: - questClick
    @objc private func questClick() {
        let clabeAlertView = ClabeAlertView()
        UIApplication.shared.windows.first?.addSubview(clabeAlertView)
    }
    
    //MARK: - nextClick
    override func nextClick() {
        var subDic:[String:String] = [:]
        
        var isDone = false
        let typeCode = self.dataSource[1]["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].stringValue
        let typeValue = self.dataSource[1]["DtdjYPPNFBqrfkqM"].stringValue
        for dic in self.dataSource[1]["tRgdyTXKVIliMaJOtxuOHYvRQUJHsV"].arrayValue{
            if typeValue == dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue{
                isDone = true
                break
            }
        }
        if isDone{
            subDic[typeCode] = typeValue
        }else{
            Toast.show(content: "Elige tu tipo de cuenta")
            return
        }
        
        isDone = false
        let bankCode = self.dataSource[2]["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].stringValue
        let bankValue = self.dataSource[2]["DtdjYPPNFBqrfkqM"].stringValue
        for dic in self.dataSource[2]["tRgdyTXKVIliMaJOtxuOHYvRQUJHsV"].arrayValue{
            if bankValue == dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue{
                isDone = true
                break
            }
        }
        if isDone{
            subDic[bankCode] = bankValue
        }else{
            Toast.show(content: "Por favor seleccione una tarjeta bancaria")
            return
        }
        
        let txt = accountFiled.text ?? ""
        let acountStr = txt.replacingOccurrences(of: "-", with: "")
        var maxCount = 16
        if let typeStr = accountLab.text,typeStr.contains("CLABE"){
            maxCount = 18
        }
        if acountStr.count != maxCount{
            Toast.show(content: "Por favor, introduzca el número de tarjeta bancaria correcto")
            return
        }
        
        let accountCode = self.dataSource[3]["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].stringValue
        subDic[accountCode] = acountStr
        subDic["yPIpfzncLDuktqTgNlFIuOLsjr"] = self.productId
        
        let confirmV = BankConfirmView(types: maxCount==16 ? 0 : 1, accountStr: txt)
        UIApplication.shared.windows.first?.addSubview(confirmV)
        confirmV.sureClick = {
            
            Network.post(path: .bankSave,parameters: subDic,loading: true) { [weak self] res, error in
                if res.success {
                    self?.riskInfo("10")
                    let next = res.data["naWCFDhRLBJqBrBQfaZWSolBwWXLf"]["aYpunaUVRMtpaveiMxSZ"].stringValue
                    Applyed.nextStep(step: next)
                }
                
            }
            
        }
    }
    
    //MARK: - dealData
    func dealWithData(changeNum:Bool = true){
        self.typeList = self.dataSource[1]["tRgdyTXKVIliMaJOtxuOHYvRQUJHsV"]
        self.bankList = self.dataSource[2]["tRgdyTXKVIliMaJOtxuOHYvRQUJHsV"]
        
        var typeStr = ""
        var accoutTitleStr = ""
        for dic in self.typeList.arrayValue{
            if dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue == self.dataSource[1]["DtdjYPPNFBqrfkqM"].stringValue{
                typeStr = dic["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
                self.typeLab.text = typeStr
                questBtn.isHidden = !typeStr.contains("CLABE")
                
                accoutTitleStr = dic["mKsoYNXaLHQHofdNQlnVFTaLyD"].stringValue
                self.accountLab.text = accoutTitleStr
            }
            
        }
        
        for dic in self.bankList.arrayValue{
            if dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue == self.dataSource[2]["DtdjYPPNFBqrfkqM"].stringValue{
                
                self.bankLab.text = dic["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
                
                if typeStr.contains("CLABE"),!isStingCheck(accoutTitleStr){
                    let cardCode = dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue
                    self.accountLab.text = accoutTitleStr+" "+String(cardCode.suffix(3))
                }
                
            }
            
        }
        
        if changeNum{
            let acountStr = self.dataSource[3]["DtdjYPPNFBqrfkqM"].stringValue
            self.accountFiled.text = formatWithHyphens(acountStr)
        }
        
        
        
    }
    
    
}
