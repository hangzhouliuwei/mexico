//
//  ContactInfoVC.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/3.
//

import UIKit
import ContactsUI

class ContactInfoVC: CertBaseVC, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactCell(style: .default, reuseIdentifier: "ContactCell_\(indexPath.section)_\(indexPath.row)")
        let cellData = dataList[indexPath.row]
        cell.configData(json: cellData)
        cell.clickBlock = { id in
            if id == 0{
                let singleV = SingleSelectView(dataList: cellData["LOfignqbeqvXxKCFguNtcgIcKAwl"], defaulValue: cellData["IFjTwGIfETpovJDfy"]["LOfignqbeqvXxKCFguNtcgIcKAwl"].stringValue)
                UIApplication.shared.windows.first?.addSubview(singleV)
                singleV.clickBlock = { str in
                    self.dataList[indexPath.row]["IFjTwGIfETpovJDfy"]["LOfignqbeqvXxKCFguNtcgIcKAwl"].stringValue = str
                    self.contactTabv.reloadData()
                }
            }else if id == 1{
                self.contactTag = indexPath.row
                self.showContactPicker()
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    

    var dataList:[JSON] = []
    var contactTag:Int = 0
    
    private lazy var contactTabv: UITableView = {
        let contactTabv = UITableView(frame: .zero, style: .plain)
        contactTabv.backgroundColor = .clear
        contactTabv.separatorStyle = .none
        contactTabv.showsVerticalScrollIndicator = false
        contactTabv.showsHorizontalScrollIndicator = false
        contactTabv.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        contactTabv.delegate = self
        contactTabv.dataSource = self
        return contactTabv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
        loadData()
    }
    
    //MARK: - loadData
    func loadData(){
        let params:[String:Any] = ["weFhdKNVhVVAAczmVVwiHW":UserM.phone,
                                   "yPIpfzncLDuktqTgNlFIuOLsjr":productId,
                                   "dzmvRugVqAmPPKlvxr":"54qw",
                                   "ddniVRYBAYEJZIsyJCt":"985"]
        Network.post(path: .extGet, parameters: params,loading: true) { res, error in
            self.dataList = res.data["JamHxgHiTYxClKqWjuvfkXlPLn"].arrayValue
            self.contactTabv.reloadData()
        }
        
    }
    
    //MARK: - loadUI
    func loadUI(){
        contentView.addSubview(contactTabv)
        contactTabv.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
  
    // MARK: - showContactPicker
    func showContactPicker() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    // MARK: - CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.dataList[self.contactTag]["IFjTwGIfETpovJDfy"]["weFhdKNVhVVAAczmVVwiHW"].stringValue = contact.phoneNumbers.first?.value.stringValue ?? ""
        self.dataList[self.contactTag]["IFjTwGIfETpovJDfy"]["NnfawhNtmBUUfabHrKnvuPhg"].stringValue = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
        self.contactTabv.reloadData()
    }
    
    override func nextClick() {
        var subDic:[String:String] = ["yPIpfzncLDuktqTgNlFIuOLsjr":self.productId]
        for dic in dataList{
            let relationKey = dic["bdccchxmydtAPUPPxlEbCWqj"][0]["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
            let mobileKey = dic["bdccchxmydtAPUPPxlEbCWqj"][1]["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
            let nameKey = dic["bdccchxmydtAPUPPxlEbCWqj"][2]["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
            
            let relationValue = dic["IFjTwGIfETpovJDfy"]["LOfignqbeqvXxKCFguNtcgIcKAwl"].stringValue
            let mobileValue = dic["IFjTwGIfETpovJDfy"]["weFhdKNVhVVAAczmVVwiHW"].stringValue
            let nameValue = dic["IFjTwGIfETpovJDfy"]["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
            if isStingCheck(relationValue){
                Toast.show(content: "Por favor seleccione una relación")
                return
            }
            subDic[relationKey] = relationValue
            
            if isStingCheck(mobileValue) || isStingCheck(nameValue){
                Toast.show(content: "Por favor, rellene la información de la libreta de direcciones")
                return
            }
            subDic[mobileKey] = mobileValue
            subDic[nameKey] = nameValue
        }
        
        Network.post(path: .extSave, parameters: subDic, loading: true) { [weak self] res, error in
            if res.success {
                self?.riskInfo("9")
                let next = res.data["naWCFDhRLBJqBrBQfaZWSolBwWXLf"]["aYpunaUVRMtpaveiMxSZ"].stringValue
                Applyed.nextStep(step: next)
            }
        }
        
    }

}
