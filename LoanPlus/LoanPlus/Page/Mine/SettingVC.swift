//
//  SettingVC.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/4.
//

import UIKit

class SettingVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Configuración"
        view.backgroundColor = .lightMain
        
        let icons = UIImageView()
        icons.image = UIImage(named: "appicon")
        view.addSubview(icons)
        
        let nameLab = UILabel.create(text: DeviceManager.getAppName(), textColor: .textBlack, font: .font_pfm(18))
        nameLab.textAlignment = .center
        view.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        icons.snp.makeConstraints { make in
            make.bottom.equalTo(nameLab.snp.top).offset(-15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        let cerrarBtn = UIButton.create(title: "Cerrar sesión",titleColor: .white,font: .fontBold(18))
        cerrarBtn.addTarget(self, action: #selector(clearClick(_ :)), for: .touchUpInside)
        cerrarBtn.cornerRadius = 25
        cerrarBtn.backgroundColor = .black
        cerrarBtn.tag = 11
        view.addSubview(cerrarBtn)
        
        let cancelBtn = UIButton.create(title: "Cancelar cuenta",titleColor: .textBlack,font: .fontBold(18))
        cancelBtn.addTarget(self, action: #selector(clearClick(_ :)), for: .touchUpInside)
        cancelBtn.cornerRadius = 25
        cancelBtn.backgroundColor = .clear
        cancelBtn.borderColor = .black
        cancelBtn.borderWidth = 1
        cancelBtn.tag = 22
        view.addSubview(cancelBtn)
        
        cerrarBtn.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-SafeBottomHeight-20)
            make.height.equalTo(50)
        }
        cancelBtn.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.bottom.equalTo(cerrarBtn.snp.top).offset(-20)
            make.height.equalTo(50)
        }
        
        cerrarBtn.setGradientText(colors: [UIColor.init(r: 0, g: 181, b: 186),UIColor.init(r: 196, g: 253, b: 126)])
    }
    
    @objc func clearClick(_ sender:UIButton){
        let outAletV = LogOutAlertV(type: sender.tag)
        UIApplication.shared.windows.first?.addSubview(outAletV)
        outAletV.sureClick = {
            self.logOUt()
        }
        
    }
    
    func logOUt(){
        Network.post(path: .loginOut,loading: true) { res, error in
            if res.success{
                UserM.logouted()
                Page.showHomeScreen()
            }
        }
        
    }
    
    
    
    

}
