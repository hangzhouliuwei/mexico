//
//  LoginVC.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//

import UIKit
import YYText

class LoginVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.navBar.backgroundColor = .clear
        view.bringSubviewToFront(navBar)
    }
    
    func setUI() {
        let loginBackImage = UIImageView(image: UIImage(named: "login_back"))
        view.addSubview(loginBackImage)
        loginBackImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(262 * KScale)
        }
        
        let appLogoImage = UIImageView(image: UIImage(named: "appicon"))
        view.addSubview(appLogoImage)
        appLogoImage.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(48)
            make.left.equalTo(22)
            make.width.height.equalTo(60 * KScale)
        }
        
        let tipImage = UIImageView(image: UIImage(named: "login_tip"))
        view.addSubview(tipImage)
        tipImage.snp.makeConstraints { make in
            make.leading.equalTo(appLogoImage.snp.leading)
            make.top.equalTo(appLogoImage.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 213 * KScale, height: 26 * KScale))
        }
        
        let tipLabel = UILabel.create(text: "Para facilitar el contacto, ingrese su número celular habitual",textColor: UIColor(hex: "#67728A"), font: .font(16))
        tipLabel.numberOfLines = 2
        view.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(tipImage.snp.bottom).offset(6)
        }
        
        view.addSubview(phoneNoInputView)
        phoneNoInputView.snp.makeConstraints { make in
            make.right.left.equalTo(0)
            make.top.equalTo(tipLabel.snp.bottom).offset(30)
            make.height.equalTo(60 * KScale)
        }
        phoneNoInputView.inputBlock = { ret in
           // print("lw======>",ret,self.phoneNoInputView.text)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(phoneNoInputView.snp.bottom).offset(48)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        
        nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        addBtnText()
        
        
       
        let label = YYLabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.frame = CGRect(x: 50, y: ScreenHeight - 90, width: ScreenWidth - 67, height: 100)
        view.addSubview(label)

        let fullText = "He leído y estoy de acuerdo con \"Acuerdo de Privacidad\",\"Acuerdo de Préstamo\""

        let attributedText = NSMutableAttributedString(string: fullText)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .left

        // 默认样式
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(hex: "#666666") ?? .black,
            .paragraphStyle: paragraphStyle
        ]
        attributedText.addAttributes(defaultAttributes, range: NSRange(location: 0, length: fullText.count))

        if let rangePrivacy = fullText.range(of: "\"Acuerdo de Privacidad\"") {
            let nsRange = NSRange(rangePrivacy, in: fullText)
            let highlightPrivacy = createHighlight { [weak self] in
                self?.handleClick(link: "Acuerdo de Privacidad")
            }
            attributedText.addAttributes([
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(hex: "#3377FF")!,
            ], range: nsRange)
            attributedText.yy_setTextHighlight(highlightPrivacy, range: nsRange)
        }

    
        if let rangeLoan = fullText.range(of: "\"Acuerdo de Préstamo\"") {
            let nsRange = NSRange(rangeLoan, in: fullText)
            let highlightrangeLoan = createHighlight { [weak self] in
                self?.handleClick(link: "Acuerdo de Préstamo")
            }
            attributedText.addAttributes([
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(hex: "#3377FF")!,
            ], range: nsRange)
            attributedText.yy_setTextHighlight(highlightrangeLoan, range: nsRange)
        }
        
        label.attributedText = attributedText
        label.sizeToFit()
        
        selectBtn.frame = CGRect(x: 0, y: Int(ScreenHeight) - 102, width: 50, height: 40)
        view.addSubview(selectBtn)
    }
    
    
   
    private func createHighlight(action: @escaping () -> Void) -> YYTextHighlight {
        let highlight = YYTextHighlight()
        highlight.setColor(UIColor.blue.withAlphaComponent(0.5))
        highlight.tapAction = { _, _, _, _ in
            action()
        }
        return highlight
    }

   
    private func handleClick(link: String) {
        if link == "Acuerdo de Privacidad"{
                let proweb =  ProWebViewController()
                proweb.url = PrivacyPath
                proweb.modalPresentationStyle = .fullScreen
                present(proweb, animated: true, completion: nil)
        }else{
            let proweb =  ProWebViewController()
            proweb.url = LoanPath
            proweb.modalPresentationStyle = .fullScreen
            present(proweb, animated: true, completion: nil)
        }
        
    }
    
    @objc func nextBtnClick () {
        if !selectBtn.isSelected {
            Toast.show(content: "Acepte el Acuerdo de privacidad y el Acuerdo de préstamo")
            return
        }
        let phoneNmber = self.phoneNoInputView.text.replacingOccurrences(of: " ", with: "")
        if phoneNmber.count < 8{
            Toast.show(content: "Por favor, introduzca un número de teléfono móvil válido")
            return
        }
       
        let  loginCodeVC = LoginCodeVC()
        loginCodeVC.phoneNmber = phoneNmber
        navigationController?.pushViewController(loginCodeVC, animated: true)
    }
    
    func addBtnText() {
        
        let label = UILabel()
        label.text = "Iniciar sesión"
        label.font = UIFont.font(16)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 40, height: 50)
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let textImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 40, height: 50)
        gradientLayer.colors = [
            UIColor(hex: "#C4FD7E")!.cgColor,
            UIColor(hex: "#7BF9EA")!.cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        
        let maskLayer = CALayer()
        maskLayer.contents = textImage?.cgImage
        maskLayer.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 40, height: 50)
        gradientLayer.mask = maskLayer
        
        nextBtn.layer.addSublayer(gradientLayer)
        
    }
    
    //MARK: changeSelected
    @objc func changeSelected(){
        selectBtn.isSelected = !selectBtn.isSelected
    }
    
    // MARK: - Lazy Properties
    lazy var nextBtn : UIButton = {
        let  nextBtn = UIButton.create()
        nextBtn.backgroundColor = UIColor(hex: "#000000")
        nextBtn.layer.cornerRadius = 25
        nextBtn.clipsToBounds = true
        return nextBtn
    }()
    
    lazy var phoneNoInputView: PhoneNoInputView = {
        let phoneNoInputView = PhoneNoInputView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
        phoneNoInputView.backgroundColor = .white
        
        return phoneNoInputView
    }()
    
    lazy var selectBtn: UIButton = {
        let selectBtn = UIButton()
        selectBtn.setImage(UIImage(named: "login_agree_no"), for: .normal)
        selectBtn.setImage(UIImage(named: "login_agree_yes"), for: .selected)
        selectBtn.isSelected = true
        selectBtn.addTarget(self, action: #selector(changeSelected), for: .touchUpInside)
        return selectBtn
    }()
    
}
