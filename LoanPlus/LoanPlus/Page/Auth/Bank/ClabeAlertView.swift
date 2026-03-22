//
//  ClabeAlertView.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/2.
//

import UIKit

class ClabeAlertView: UIView {
    
    let contenV = UIView()
    var cancelBtn = UIButton()
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.backgroundColor = .grayHalfColor
        
        contenV.backgroundColor = .white
        contenV.cornerRadius = 16
        addSubview(contenV)
        contenV.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(38)
            make.centerY.equalToSuperview().offset(-40)
            make.height.equalTo(76+320)
        }
        
        let headImg = UIImageView()
        headImg.image = UIImage(named: "alet_headview")
        headImg.contentMode = .scaleAspectFill
        contenV.addSubview(headImg)
        headImg.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(76)
        }
        
        let titleLab = UILabel.create(text: "¿Cómo obtengo mi cuenta de banco CLABE ?", textColor: .textBlack, font: .font_pfr(18))
        titleLab.numberOfLines = 0
        titleLab.textAlignment = .center
        contenV.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(27)
            make.height.equalTo(54)
        }
        
        let closeBtn = UIButton.create()
        closeBtn.setImage(UIImage(named: "alert_close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        contenV.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        contenV.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(6)
            make.left.right.bottom.equalToSuperview()
        }
        
        cancelBtn = UIButton.create(title: "OK",titleColor: .white,font: .font_pfr(18))
        cancelBtn.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
        cancelBtn.cornerRadius = 25
        cancelBtn.backgroundColor = .black
        bottomView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        let contentLab = UILabel.create(text: "El número que requerimos es tu CLABE interbancaria. Consta de 18 dígitos y lo puedes obtener de forma muy sencilla: \n1.en la aplicación de tu banco al acceder con tu cuenta \n2.en uno de tus estados de cuenta \n3.en la carátula de tu contrato con el banco \n4.acudiendo directamente a la sucursal o \n5.llamando al número telefónico que aparece en la parte de atrás de tu tarjeta.", textColor: .textBlack, font: .font_pfr(14))
        contentLab.numberOfLines = 0
        contentLab.adjustsFontSizeToFitWidth = true
        contentLab.minimumScaleFactor = 0.5
        bottomView.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(cancelBtn.snp.top).offset(-10)
        }
        
        contenV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animate(withDuration: 0.3) {
            self.contenV.transform = .identity
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.setGradientText(colors: [UIColor.init(r: 0, g: 181, b: 186),UIColor.init(r: 196, g: 253, b: 126)])
    }
    
    @objc func closeAlert(){
        UIView.animate(withDuration: 0.3) {
            self.contenV.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }completion: { bol in
            self.removeFromSuperview()
        }
    }
    

}
