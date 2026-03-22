//
//  IDCardVC.swift
//  LoanPlus
//
//  Created by hao on 2024/11/29.
//

import UIKit

class IDCardVC: CertBaseVC {
    var faceId = ""
    var faceImage = UIImage()
    var frontUrl = ""
    var backUrl = ""
    var cardName = ""
    var cardNumber = ""
    var faceStatus = ""
    let frontImage = UIButton(type: .custom)
    let backImage = UIButton(type: .custom)
    let content = UIScrollView()
    let itemView = UIView()
    let faceView = UIView()
    var selectType = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        pushRemove = false
        requestData()
    }
    
    func refreshUI() {
        content.frame = CGRect(x: 15, y: 0, width: ScreenWidth - 30, height: contentView.height - 15)
        content.cornerRadius = 15
        content.backgroundColor = .white
        contentView.addSubview(content)
        content.showsVerticalScrollIndicator = false

        frontImage.frame = CGRect(x: 30, y: 30, width: content.width - 60, height: (content.width - 60)*175/285.0)
        frontImage.kf.setBackgroundImage(with: URL(string: frontUrl), for: .normal, placeholder: UIImage(named: "cert_credit_front"))
        frontImage.cornerRadius = 8
        if !isDone {
            frontImage.addTap { [weak self] in
                if self?.frontUrl.count == 0 {
                    self?.nextClick()
                }
            }
        }
        
        content.addSubview(frontImage)
        
        backImage.frame = CGRect(x: 30, y: frontImage.bottom + 30, width: content.width - 60, height: (content.width - 60)*175/285.0)
        backImage.kf.setBackgroundImage(with: URL(string: backUrl), for: .normal, placeholder: UIImage(named: "cert_credit_back"))
        backImage.cornerRadius = 8
        if !isDone {
            backImage.addTap { [weak self] in
                if self?.backUrl.count == 0 {
                    self?.nextClick()
                }
            }
        }
        
        content.addSubview(backImage)
        var offsetY = backImage.bottom
        itemView.removeAllSubviews()
        if !frontUrl.isEmpty {
            itemView.frame = CGRect(x: 15, y: backImage.bottom + 30, width: content.width - 30, height:200)
            content.addSubview(itemView)
            
            let nameTitle = UILabel(frame: CGRect(x: 0, y: 0, width: itemView.width, height: 17))
            nameTitle.textColor = UIColor(hex: 0x67728A)
            nameTitle.font = .font(13)
            nameTitle.text = "ID nombre nombre"
            itemView.addSubview(nameTitle)
            
            let nameValue = UILabel(frame: CGRect(x: 0, y: nameTitle.bottom + 12, width: itemView.width, height: 48))
            nameValue.backgroundColor = .init(hex: 0xF6F8FA)
            nameValue.textColor = UIColor(hex: 0x0B1A3C)
            nameValue.font = .fontMedium(13)
            nameValue.text = "    \(cardName)"
            nameValue.cornerRadius = 4
            itemView.addSubview(nameValue)
            
            let idTitle = UILabel(frame: CGRect(x: 0, y: nameValue.bottom + 12, width: itemView.width, height: 17))
            idTitle.textColor = UIColor(hex: 0x67728A)
            idTitle.font = .font(13)
            idTitle.text = "ID números"
            itemView.addSubview(idTitle)
            
            let idValue = UILabel(frame: CGRect(x: 0, y: idTitle.bottom + 12, width: itemView.width, height: 48))
            idValue.backgroundColor = .init(hex: 0xF6F8FA)
            idValue.textColor = UIColor(hex: 0x0B1A3C)
            idValue.font = .fontMedium(13)
            idValue.text = "    \(cardNumber)"
            idValue.cornerRadius = 4
            itemView.addSubview(idValue)
            
            itemView.height = idValue.bottom
            offsetY = itemView.bottom
        }

        faceView.removeAllSubviews()
        if !backUrl.isEmpty {
            faceView.frame = CGRect(x: 15, y: itemView.bottom + 12, width: content.width - 30, height: 56)
            content.addSubview(faceView)
            offsetY = faceView.bottom
            
            let leading = IconButton(frame: CGRect(x: 0, y: 0, width: faceView.width, height: faceView.height), title: "  Servicio en línea", color: .init(hex: 0x181818), font: .fontBold(15), icon: "face_leading")
            leading.isUserInteractionEnabled = false
            leading.setType(type: .type2)
            faceView.addSubview(leading)
            
            let didAuthFace = faceStatus == "1" || !faceId.isEmpty
            
            let ending = IconButton(frame: CGRect(x: 0, y: 0, width: faceView.width, height: faceView.height), title: didAuthFace ? "Verificado" : "Sin verificar", color: .init(hex: didAuthFace ? 0x1C970F : 0x67728A), font: .font(13), icon: didAuthFace ? "" : "cert_unselect_icon")
            ending.isUserInteractionEnabled = false
            ending.setType(type: .type4)
            faceView.addSubview(ending)
            if !isDone {
                faceView.addTap { [weak self] in
                    self?.nextClick()
                }
            }
            faceView.isUserInteractionEnabled = !didAuthFace
            
        }
        content.contentSize = CGSize(width: content.width, height: offsetY + 16)
    }
    
    override func nextClick() {
        if isDone {
            closeVC()
            return
        }
        if frontUrl.isEmpty  {
            self.selectType = 1
            self.selectAlert()
            return
        }
        
        if backUrl.isEmpty {
            self.selectType = 2
            self.selectAlert()
            return
        }
        
        if faceId.isEmpty || faceImage.size.width == 0 {
            self.selectType = 0
            self.selectAlert()
            return
        }
        pushRemove = true
        self.uploadImage(image: faceImage)
    }
    
    func requestData() {
        let dic = [
            "yPIpfzncLDuktqTgNlFIuOLsjr":productId,
            "weFhdKNVhVVAAczmVVwiHW": UserM.phone,
            "nUjJLpsEHMMEQUAoylaQcyevzMMv":"236541",
        ]
        Network.post(path: .publicGet, parameters: dic, loading: true) { [weak self] res, error in
            if res.success {
                self?.loadUI(res: res.data)
            }
        }
    }
    
    func loadUI(res:JSON) {
        frontUrl = res["YjrHvzWLuersEaQdUgyUtFbbjEstZ"]["QMhNOYRoRAAQmsLJAMkjm"].stringValue
        backUrl = res["StBorWKXknPLsxebbV"]["QMhNOYRoRAAQmsLJAMkjm"].stringValue
        cardName = res["YjrHvzWLuersEaQdUgyUtFbbjEstZ"]["kGSMgDHTeqlKKcfLfNtginbsrpHC"]["NnfawhNtmBUUfabHrKnvuPhg"].stringValue
        cardNumber = res["YjrHvzWLuersEaQdUgyUtFbbjEstZ"]["kGSMgDHTeqlKKcfLfNtginbsrpHC"]["QPDrgoFQtBMHUPoASGQTsyN"].stringValue
        faceStatus = res["dvMSGfqmQrwHMtlGFrPDgWyUnHd"]["GygsgiVLIfZfYuWAQe"].stringValue
        refreshUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshUI()
    }
    
    func selectAlert() {
        self.inTime = String.nowTimeString()
        let alert = UIImageView(frame: CGRect(x:0, y: 0, width: ScreenWidth - 75.w, height: 463.w))
        alert.isUserInteractionEnabled = true
        alert.center = view.center
        alert.image = UIImage(named: ["face_alert", "front_alert", "back_alert"][selectType])
        CustomAlert.show(contentView: alert)
        
        let close = UIView(frame: CGRect(x: alert.width - 44, y: 0, width: 44, height: 44))
        alert.addSubview(close)
        close.addTap {
            CustomAlert.hideAlert()
        }
        
        let confirm = UIView(frame: CGRect(x: 20.w, y: alert.height - 78.w, width: alert.width - 40.w, height: 52.w))
        alert.addSubview(confirm)
        confirm.addTap { [weak self] in
            CustomAlert.hideAlert()
            self?.selectPhoto()
        }
    }
    
    func selectPhoto() {
        if selectType == 0 {
            getLicense()
            return
        }
        PhotoSelector.selectPhoto() { [weak self] result in
            if let image = result as? UIImage {
                self?.uploadImage(image:image)
            }
        }
    }
    
    func getLicense() {
        Network.post(path: .getLicense, parameters: ["yPIpfzncLDuktqTgNlFIuOLsjr":productId, "mobilePhone":UserM.phone], loading: true) { [weak self] res, error in
            if res.success {
                let license = res.data["UrigPoKHhEIAvFxvwLVficUKiP"].stringValue
                self?.faceAuth(license)
            }
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func faceAuth(_ license:String) {
        AAILivenessSDK.initWith(AAILivenessMarket.mexico)
        AAILivenessSDK.configResultPictureSize(800)
        AAILivenessSDK.configDetectOcclusion(true)
        AAILivenessSDK.additionalConfig().detectionLevel = .easy
        let authStatus = AAILivenessSDK.configLicenseAndCheck(license)
        if authStatus == "SUCCESS" {
            let vc = AAILivenessViewController()
            vc.prepareTimeoutInterval = 100
            vc.navigationController?.delegate = self
            vc.detectionSuccessBlk = { [weak self] rawVC, result in
                let livenessId = result.livenessId
                let faceImg = result.img
                Page.pop(animated: true)
                if !livenessId.isEmpty {
                    self?.faceId = livenessId
                    self?.faceImage = faceImg
                    self?.refreshUI()
                } else {
                    Toast.show(content: "La autenticación falló. Por favor, inténtelo de nuevo")
                }
            }
            vc.detectionFailedBlk = { rawVC, errorInfo in
                Toast.show(content: "La autenticación falló. Por favor, inténtelo de nuevo")
                Page.pop(animated: true)
            }
            Page.push(vc: vc)
        } else{
            Toast.show(content: "La autenticación falló. Por favor, inténtelo de nuevo")
        }
    }
    
    func uploadImage(image:UIImage) {
        var dic = ["yPIpfzncLDuktqTgNlFIuOLsjr":productId, "glSkHaJkeFpaEYPnSHbTemolVriDhR": "1", "jeLofZAQCgeCASkk":"23"]
        dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"] = ["10", "11", "12"][selectType]
        if (selectType == 0) {
            dic["UrigPoKHhEIAvFxvwLVficUKiP"] = faceId
            dic["UnCvWGTCwZaeXCkJqEgfTmEaTTTHa"] = "1"
        }
        Network.upload(path: .uploadImg, params: dic, image: image, callback: { [weak self] res, error in
            if res.success {
                self?.updateUI(res: res.data)
            }else if res.code == -1 {
                self?.faceId = ""
                self?.refreshUI()
            }
        })
    }
    
    func updateUI(res:JSON) {
        if selectType == 0 {
            let next = res["naWCFDhRLBJqBrBQfaZWSolBwWXLf"]["aYpunaUVRMtpaveiMxSZ"].stringValue
            Applyed.nextStep(step: next)
            self.riskInfo("6")
        }else if selectType == 1 {
            frontUrl = res["QMhNOYRoRAAQmsLJAMkjm"].stringValue
            cardName = res["uBIeSfGLjUOFyLjEYmNnmmj"].stringValue
            cardNumber = res["CFYdbdQKqgajqEa"].stringValue
            let needPop = res["HamWKBFehXfBJIquhXPxmkhUSAygX"].stringValue
            if needPop == "1" {
                showInfoAlert()
            }
            self.riskInfo("3")
        }else if selectType == 2 {
            backUrl = res["QMhNOYRoRAAQmsLJAMkjm"].stringValue
            self.riskInfo("4")
            self.riskInfo("5")
        }
        refreshUI()
    }
    
    func showInfoAlert() {
        let vc = CardInfoAlertVC()
        vc.navBarHidden = true
        vc.modalPresentationStyle = .overFullScreen
        vc.cardName = cardName
        vc.cardNumber = cardNumber
        vc.productId = productId
        vc.onDismiss = { [weak self] result in
            self?.cardName = result["name"] as! String
            self?.cardNumber = result["number"] as! String
            self?.refreshUI()
        }
        vc.onCancel = { [weak self] in
            self?.cancelFront()
        }
        self.present(vc, animated: false)
    }
    
    func cancelFront() {
        frontUrl = ""
        cardName = ""
        cardNumber = ""
        refreshUI()
    }
}


