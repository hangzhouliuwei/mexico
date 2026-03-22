//
//  SingleSelectView.swift
//  LoanPlus
//
//  Created by Kiven on 2024/12/2.
//

import UIKit

class SingleSelectView: UIView {
    
    var clickBlock:StringBlock?
    
    private var dataList:JSON
    private var defaulValue:String

    required init(dataList: JSON ,defaulValue:String = "") {
        self.dataList = dataList
        self.defaulValue = defaulValue
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        backgroundColor = .grayHalfColor
        addSubview(bgView)
        let count = min(5, dataList.arrayValue.count)
        let bgHeight = (count+1)*40+60+SafeBottomHeight+20
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(bgHeight)
            make.height.equalTo(bgHeight)
        }
        
        let bgImgV = UIImageView()
        bgImgV.image = UIImage(named: "alert_bgImg")
        bgImgV.contentMode = .scaleAspectFill
        bgView.addSubview(bgImgV)
        bgImgV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let cancelBtn = UIButton.create(title: "Cancelar",titleColor: .init(r: 39, g: 71, b: 191),font: .font_pfr(15))
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        bgView.addSubview(cancelBtn)
//        bgView.addSubview(confirmBtn)
        cancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 92, height: 33))
        }
//        confirmBtn.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(21)
//            make.right.equalToSuperview().offset(-20)
//            make.size.equalTo(CGSize(width: 92, height: 33))
//        }
        
        bgView.addSubview(selectCollectV)
        selectCollectV.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().offset(-SafeBottomHeight-20)
            make.top.equalToSuperview().offset(60)
        }
        
        selectCollectV.layoutIfNeeded()
        for (index,dic) in dataList.arrayValue.enumerated() {
            if dic["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue == defaulValue{
                selectCollectV.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false)
                break
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.bgView.transform = CGAffineTransformMakeTranslation(0, -bgHeight)
        }
        
    }
    
    private lazy var bgView:UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 16
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bgView
    }()
    
//    private lazy var confirmBtn:UIButton = {
//        let confirmBtn = UIButton.create(title: "Confirmar",titleColor: .white,font: .font_pfm(15))
//        confirmBtn.addTarget(self, action: #selector(confirmClick), for: .touchUpInside)
//        confirmBtn.cornerRadius = 16.5
//        confirmBtn.backgroundColor = .black
//        return confirmBtn
//    }()
    
    private lazy var selectCollectV:UICollectionView = {
        let lays = UICollectionViewFlowLayout()
        lays.itemSize = CGSize(width: ScreenWidth-30, height: 40)
        lays.minimumLineSpacing = 0
        lays.minimumInteritemSpacing = 0
        lays.scrollDirection = .vertical
        lays.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        var selectCollectV = UICollectionView(frame: CGRectZero, collectionViewLayout: lays)
        selectCollectV.delegate = self
        selectCollectV.dataSource = self
        selectCollectV.backgroundColor = .white
        selectCollectV.bounces = false
        selectCollectV.cornerRadius = 12
        selectCollectV.register(SelectCell.self, forCellWithReuseIdentifier: "SelectCell")
        return selectCollectV
    }()
    
    @objc func cancelClick(){
        UIView.animate(withDuration: 0.2) {
            self.bgView.transform = .identity
        }completion: { over in
            self.removeFromSuperview()
        }
        
    }
    
//    @objc func confirmClick(){
//        
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        confirmBtn.setGradientText(colors: [UIColor.init(r: 0, g: 181, b: 186),UIColor.init(r: 196, g: 253, b: 126)])
//    }

}

extension SingleSelectView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.arrayValue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indexNum = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCell", for: indexPath) as? SelectCell{
            let json = dataList.arrayValue[indexNum]
            var isSelected:Bool = false
            if !isStingCheck(defaulValue) && json["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue == defaulValue{
                isSelected = true
            }
            cell.configJson(json: dataList.arrayValue[indexNum], isSelected: isSelected)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newValue = dataList.arrayValue[indexPath.row]["MxpNpYKadDRvmjqybUjsIEARDwIwW"].stringValue
        if defaulValue != newValue{
            defaulValue = newValue
            collectionView.reloadData()
        }
        cancelClick()
        if (self.clickBlock != nil) {
            self.clickBlock!(newValue)
        }
        
    }
    
    
}
