//
//  LoginCodeVC.swift
//  LoanPlus
//
//  Created by 刘巍 on 2024/11/26.
//

import UIKit
import YYText
import KeenCodeUnit

class LoginCodeVC: BaseVC {
    var isloading = false
    var phoneNmber : String = ""
    private var codeUnit: KeenCodeUnit!
    override func viewDidLoad() {
        super.viewDidLoad()
        Localed.starts()
        setUI()
        self.navBar.backgroundColor = .clear
        view.bringSubviewToFront(navBar)
        getphoneNmberCode()
    }
    
    override func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func setUI() {
        let loginBackImage = UIImageView(image: UIImage(named: "login_back"))
        view.addSubview(loginBackImage)
        loginBackImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(262 * KScale)
        }
        
        let appLogoImage = UIImageView(image: UIImage(named: "appicon"))
        appLogoImage.frame = CGRect(x: 20, y: Int(navBar.bottom) + 48, width: 60 * Int(KScale), height: 60 * Int(KScale))
        view.addSubview(appLogoImage)
      
        
        let tipImage = UIImageView(image: UIImage(named: "loginCode_tip"))
        tipImage.frame = CGRect(x: 20, y: Int(appLogoImage.bottom) + 20, width: 140 * Int(KScale), height: 26 * Int(KScale))
        view.addSubview(tipImage)
       
        
        let phoneNubeLabel = YYLabel()
        phoneNubeLabel.numberOfLines = 0
        let fullText = "El código de confirmación ha sido enviado al número de teléfono registrado " + phoneNmber
        let attributedText = NSMutableAttributedString(string: fullText)
        attributedText.yy_font = .font(13)
        attributedText.yy_color = UIColor(hex: "#67728A")
        
        if let phoneRange = fullText.range(of: phoneNmber) {
            let nsRange = NSRange(phoneRange, in: fullText)
            attributedText.yy_setFont(UIFont.boldSystemFont(ofSize: 14), range: nsRange)
            attributedText.yy_setColor(UIColor(hex: "#0B1A3C"), range: nsRange)
        }

        phoneNubeLabel.attributedText = attributedText
        phoneNubeLabel.frame = CGRect(x: 20, y: Int(tipImage.bottom) + 6, width: Int(ScreenWidth) - 40, height: 48)
        view.addSubview(phoneNubeLabel)
        
        let phoneCodeLabel = UILabel.create(text: "Código de verificación de 6 dígitos", textColor: UIColor(hex: "#B1B9C9"), font: .font(13))
        view.addSubview(phoneCodeLabel)
        phoneCodeLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(phoneNubeLabel.snp.bottom).offset(10)
            make.height.equalTo(22)
        }
        
        view.addSubview(codeBtn)
        codeBtn.snp.makeConstraints { make in
            make.right.equalTo(-22)
            make.centerY.equalTo(phoneCodeLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
    
        codeBtn.clickBtnEvent = { [weak self]  in
               guard let self = self else { return }
            if !self.codeBtn.isWorking{
                self.getphoneNmberCode()
            }
        }
        
        
        let rect = CGRect(x: 20, y: phoneNubeLabel.bottom + 62, width: ScreenWidth - 40, height: 44)
        var attr = KeenCodeUnitAttributes()
        attr.cursorColor = UIColor(hex: "#2747BF")!
        attr.borderColor = UIColor(hex: "#D4D7DE")!
        attr.borderHighlightedColor = UIColor(hex: "#2747BF",alpha: 0.5)!
        attr.style = .splitborder
        attr.textFont = .boldSystemFont(ofSize: 20)
        attr.isSingleAlive = true
        codeUnit = KeenCodeUnit(
            frame: rect,
            attributes: attr
        ).addViewTo(view)
        
        codeUnit.callback = { (codeText, complete) in
            if complete {
                self.getLogin(phoneCode: codeText)
            }
        }
    }
    
    func getphoneNmberCode(){
        let dic = ["edaNAeNIRZZqdssKkRV":self.phoneNmber,"oAPxpddafRSComN":"jnehwbbrb"]
        Network.post(path: .getCode,parameters:dic,loading: true) { res, error in
            
            var time = res.data["AKDaQpLIziPsAlUT"]["IstzwaBcwxnfqweUSYmisS"].intValue
            if res.code == 0 {
                Toast.show(content:res.data["AKDaQpLIziPsAlUT"]["sULmmkIBKPDlleIxDFJcNLy"].string ?? "Se mandó el código de verificación con éxito")
                time = 60
            }else{
                Toast.show(content: res.msg)
            }
            if time > 0{
                self.codeBtn.setup("Obtener código", timeTitlePrefix: "", aTimeLength: time)
                self.codeBtn.isWorking = true
                self.codeBtn.clickBtn(self.codeBtn)
            }
            
            
        }
        
    }
    
    
    func getLogin(phoneCode:String){
        if isloading{
            return
        }
        isloading = true
        let dic = ["horKHOwbtZuchWPDKxZeVpMfteUWM":self.phoneNmber,"hKPfDdOLfQZZfJTOPcszTWWCV": phoneCode,"GVWkpGQVSANRwsCheBvUTCCIIew":"canenner"]
        Network.post(path: .login,parameters:dic,loading: true) { res, error in
            if res.code == 0 {
                let phone = res.data["horKHOwbtZuchWPDKxZeVpMfteUWM"].stringValue
                let sessionId = res.data["WkRcXjNfHkSrzdZkcoXHEQoJ"].stringValue
                if phone.count > 0, sessionId.count > 0 {
                    UserM.phone = phone
                    UserM.sessionId = sessionId
                    NotificationCenter.default.post(name: home_update, object: nil)
                    Page.navigationVC?.dismiss(animated: true)
                }
            }else{
                self.codeUnit.verifyErrorAction()
                Toast.show(content:res.msg, time: 1.5)
            }
            
            self.isloading = false
            
        }
        
    }
    
    // MARK: - Lazy Properties
    lazy var codeBtn : CaptchaButton = {
        let  nextBtn = CaptchaButton()
        return nextBtn
    }()
    
}
