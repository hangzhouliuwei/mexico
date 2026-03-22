//
//  SurveyVC.swift
//  LoanPlus
//
//  Created by hao on 2024/11/27.
//

import UIKit

class SurveyVC: CertBaseVC {
    var list = [JSON]()
    let listView = UIView()
    
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        listView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 0)
        listView.backgroundColor = .white
        scrollView.addSubview(listView)
        requestData()
    }
    
    func selectAction(value:JSON, index:Int) {
        var tmp = self.list
        tmp[index] = value
        self.list = tmp
    }
    
    func refreshUI() {
        listView.removeAllSubviews()
        var offsetY = 0.0
        for (i, data) in list.enumerated() {
            let cell = SurveyCell(frame: CGRect(x: 0, y: offsetY, width: ScreenWidth, height: 0))
            cell.config(data: data, index: i)
            cell.selectlock = { [weak self] res in
                self?.selectAction(value: res, index: i)
            }
            listView.addSubview(cell)
            offsetY = cell.bottom
            listView.height = offsetY
        }
        listView.addTopRound(radius: 16)
        scrollView.contentSize = CGSize(width: ScreenWidth, height: listView.bottom + 20)
    }
    
    func requestData() {
        let dic = [
            "yPIpfzncLDuktqTgNlFIuOLsjr":productId,
            "weFhdKNVhVVAAczmVVwiHW":UserM.phone,
            "EyUPDkGjUaXYWTjysnsPtCzeEzlLE":"ksjd",
            "DUfzSdmghmoXyqvZPVilW":"12315a",
            "EgTScqFUwQBvYCPoGXWKCwSdU":"3"
        ]
        Network.post(path: .surveyGet, parameters: dic, loading: true) { [weak self] res, error in
            if res.success {
                self?.list = res.data["JamHxgHiTYxClKqWjuvfkXlPLn"].arrayValue
                self?.refreshUI()
            }
        }
    }
    
    override func nextClick() {
        var dic = ["yPIpfzncLDuktqTgNlFIuOLsjr":productId, "AuIRuvZWbABSNncPYvhFsrYAqbP":"19"]
        for data in list {
            let optional = data["byjiVgLBGZQgGFGvNPbnlKFpmdGm"].intValue
            let code = data["yHduRxzXeDDhxXBcvAqiebBdHaYaM"].stringValue
            let value = data["DtdjYPPNFBqrfkqM"].stringValue
            if optional == 0 && value.isEmpty {
                Toast.show(content: "Por favor, complete la verificación")
                return
            }
            if !value.isEmpty {
                dic[code] = value
            }
        }
        
        Network.post(path: .surveySave, parameters: dic, loading: true) { [weak self] res, error in
            if res.success {
                let next = res.data["naWCFDhRLBJqBrBQfaZWSolBwWXLf"]["aYpunaUVRMtpaveiMxSZ"].stringValue
                Applyed.nextStep(step: next)
                self?.riskInfo("2")
            }
        }
    }
}

class SurveyCell:UIView {
    var selectlock :JsonBlock?
    var index = 0
    
    func config(data:JSON, index:Int) {
        self.index = index
        self.removeAllSubviews()
        let lead = UIImageView(frame: CGRect(x:0, y: 30, width: 24, height: 20))
        lead.image = UIImage(named: "survey_lead_\(index)")
        self.addSubview(lead)
        
        let title = UILabel(frame: CGRect(x: 34, y: 20, width: ScreenWidth - 50, height: 0))
        title.text = data["mKsoYNXaLHQHofdNQlnVFTaLyD"].stringValue
        title.textColor = .textBlack
        title.font = .fontMedium(15)
        title.numberOfLines = 0
        title.sizeToFit()
        title.width = ScreenWidth - 50
        addSubview(title)
        lead.centerY = title.centerY
        
        let selectType = data["DtdjYPPNFBqrfkqM"].stringValue
        let arr = data["tRgdyTXKVIliMaJOtxuOHYvRQUJHsV"].arrayValue
        
        var itemWidth = 0.0
        for item in arr {
            let content = item["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
            let size = content.size(width: title.width, font: .font(13))
            itemWidth = max(itemWidth, size.width + 48)
        }
        var count = floor(title.width/itemWidth).intValue
        count = max(count, 1)
        count = min(4, count)
        
        itemWidth = title.width/count
        let offsetX = 34.0
        let offsetY = title.bottom + 8
        
        var bottom = offsetY
        for (i, item) in arr.enumerated() {
            let name = item["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
            let type = item["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue
            let itemView = UIButton(type: .custom)
            itemView.titleLabel?.font = .font(13)
            itemView.frame = CGRect(x: offsetX + itemWidth*(i%count), y: offsetY + (i/count)*32, width: itemWidth - 16, height: 32)
            itemView.setImage(UIImage(named: "survey_unselected"), for: .normal)
            itemView.setImage(UIImage(named: "survey_selected"), for: .selected)
            itemView.setTitle(name, for: .normal)
            itemView.setTitleColor(.init(hex: 0x0B1A3C), for: .normal)
            itemView.contentHorizontalAlignment = .left
            itemView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            itemView.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
            itemView.isSelected = selectType == type
            self.addSubview(itemView)
            itemView.addTap { [weak self] in
                var tmp  = data
                tmp["DtdjYPPNFBqrfkqM"].stringValue = type
                self?.itemTap(value: tmp)
            }
            bottom = itemView.bottom + 12
        }
        let line = UIView(frame: CGRect(x: 30, y: bottom - 1, width: ScreenWidth - 60, height: 1))
        line.backgroundColor = .init(hex: 0xEEF0F4)
        line.isHidden = index == 4
        self.addSubview(line)
        self.height = bottom
    }
    
    func itemTap(value:JSON) {
        self.selectlock?(value)
        config(data: value, index: index)
    }
}
