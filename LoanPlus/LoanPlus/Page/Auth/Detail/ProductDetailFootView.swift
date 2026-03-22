//
//  ProductDetailFootView.swift
//  LoanPlus
//
//  Created by Kiven on 2024/11/26.
//

import UIKit

class ProductDetailFootView: UIView {
    
    private var data = JSON()
    
    var nextClick:VoidBlock?

    required init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(clickLab)
        addSubview(chooseBtn)
        addSubview(nextLable)
        
        nextLable.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-SafeBottomHeight)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        chooseBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21)
            make.centerY.equalTo(clickLab).offset(-4)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        clickLab.snp.makeConstraints { make in
            make.bottom.equalTo(nextLable.snp.top).offset(-10)
            make.left.equalTo(chooseBtn.snp.right).offset(10)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
    }
    
    private lazy var nextLable:UILabel = {
        let nextLable = UILabel()
        nextLable.font = UIFont.systemFont(ofSize: 18)
        nextLable.textColor = .white
        nextLable.backgroundColor = .black
        nextLable.textAlignment = .center
        nextLable.cornerRadius = 25
        let tpas = UITapGestureRecognizer(target: self, action: #selector(authClick))
        nextLable.isUserInteractionEnabled = true
        nextLable.addGestureRecognizer(tpas)
        return nextLable
    }()

    @objc private func authClick(){
        if chooseBtn.isSelected{
            if nextClick != nil{
                nextClick!()
            }
        }else{
            Toast.show(content: "Por favor lea y acepte el acuerdo.")
        }
        
    }
    
    lazy var chooseBtn:UIButton = {
        let chooseBtn = UIButton(type: .custom)
        chooseBtn.setImage(UIImage(named: "choose_no"), for: .normal)
        chooseBtn.setImage(UIImage(named: "choose_yes"), for: .selected)
        chooseBtn.addTarget(self, action: #selector(chooseClick), for: .touchUpInside)
        chooseBtn.isSelected = true
        return chooseBtn
    }()
    
    @objc private func chooseClick(){
        chooseBtn.isSelected = !chooseBtn.isSelected
    }
    
    private lazy var clickLab:UILabel = {
        let clickLab = UILabel()
        clickLab.textColor = UIColor(r: 102, g: 102, b: 102)
        clickLab.numberOfLines = 0
        clickLab.font = .systemFont(ofSize: 13)
        clickLab.isUserInteractionEnabled = true
        
        let text = "He leído y acepto el \"Acuerdo de Privacidad\" y el \"Acuerdo de Préstamo\""
        let privacyAgreementRange = (text as NSString).range(of: "\"Acuerdo de Privacidad\"")
        let loanAgreementRange = (text as NSString).range(of: "\"Acuerdo de Préstamo\"")
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(r: 51, g: 119, b: 255), range: privacyAgreementRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(r: 51, g: 119, b: 255), range: loanAgreementRange)
        clickLab.attributedText = attributedString
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        clickLab.addGestureRecognizer(tapGesture)
        
        return clickLab
    }()
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel, let attributedText = label.attributedText else { return }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let locationOfTouchInLabel = gesture.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (label.bounds.size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (label.bounds.size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x - textContainerOffset.x,
            y: locationOfTouchInLabel.y - textContainerOffset.y
        )
        
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        let privacyAgreementRange = (attributedText.string as NSString).range(of: "\"Acuerdo de Privacidad\"")
        let loanAgreementRange = (attributedText.string as NSString).range(of: "\"Acuerdo de Préstamo\"")
        
        if NSLocationInRange(indexOfCharacter, privacyAgreementRange) {
            Applyed.jumpCheck(path: PrivacyPath)
        } else if NSLocationInRange(indexOfCharacter, loanAgreementRange) {
            Applyed.jumpCheck(path: LoanPath)
        }
    }
    
    func config(data:JSON){
        self.data = data
        let buttonTitle = data["ZtPGSuqZrjKpnehiiyXIFYXAE"]["ACxCbolvnPQnuoNMSJrQpIMKxtY"].stringValue
        if !isStingCheck(buttonTitle){
            nextLable.text = buttonTitle
            
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nextLable.textColor = UIColor(patternImage: UIImage.getGradientImage(size: nextLable.bounds.size))
    }
    
}


