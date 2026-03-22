//
//  ProductDetailVC.swift
//  LoanPlus
//
//  Created by Kiven on 2024/11/25.
//

import UIKit

class ProductDetailVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num = productData["ngIDaOqoIUehaBwFNh"].arrayValue.count
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailCell", for: indexPath) as? ProductDetailCell{
            cell.config(data: productData["ngIDaOqoIUehaBwFNh"][indexPath.row],index:indexPath.row)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let status = productData["ngIDaOqoIUehaBwFNh"][indexPath.row]["GygsgiVLIfZfYuWAQe"].boolValue
        let currentPath = productData["ngIDaOqoIUehaBwFNh"][indexPath.row]["daZqMxGveDacLYfGWwFiP"].stringValue
        
        if !footView.chooseBtn.isSelected{
            Toast.show(content: "Por favor lea y acepte el acuerdo.")
            return
        }
        if status{
            Applyed.nextStep(step: currentPath,isDone: true)
        }else{
            nextClick()
        }
        
    }
    
    var pro_id:String = ""
    
    var productData = JSON()
    
    var headBanner = UIImageView()
    var footView = ProductDetailFootView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "Certificación de información")
        contentView.backgroundColor = .lightMain
        
        view.addSubview(headBanner)
        view.addSubview(authCollectView)
        view.addSubview(footView)
        headBanner.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(NavBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(ScreenWidth/375*153)
        }
        footView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(authCollectView.snp.bottom)
        }
        footView.nextClick = {
            self.nextClick()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    lazy var authCollectView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let wid = (ScreenWidth-54)/2
        let hei = wid/161*123
        layout.itemSize = CGSize(width: wid, height: hei)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        layout.scrollDirection = .vertical
        
        let y = NavBarHeight+ScreenWidth/375*153+10
        let authCollectView = UICollectionView(frame: CGRect(x: 0, y: y, width: ScreenWidth, height: ScreenHeight-y-100-SafeBottomHeight), collectionViewLayout: layout)
        authCollectView.delegate = self
        authCollectView.dataSource = self
        authCollectView.backgroundColor = .clear
        authCollectView.showsVerticalScrollIndicator = false
        authCollectView.register(ProductDetailCell.self, forCellWithReuseIdentifier: "ProductDetailCell")
        return authCollectView
    }()
    
    func refreshData(){
        Network.post(path: .productDetail,parameters: ["yPIpfzncLDuktqTgNlFIuOLsjr":pro_id]) { res, error in
            self.productData = res.data
            self.dealProductInfo()
        }
        
    }
    
    func dealProductInfo(){
        Applyed.productId = productData["ZtPGSuqZrjKpnehiiyXIFYXAE"]["aCKZvqNkalWGvsBlvdfEMrZPWfkPB"].stringValue
        
        let banner = productData["BbigmSpuneriod"].stringValue
        headBanner.kf.setImage(with: URL(string: banner))
        
        footView.config(data: self.productData)
        
        authCollectView.reloadData()
        
    }
    
    func nextClick(){
        let nextPath = productData["naWCFDhRLBJqBrBQfaZWSolBwWXLf"]["aYpunaUVRMtpaveiMxSZ"].stringValue
        if isStingCheck(nextPath){
            let amount = productData["ZtPGSuqZrjKpnehiiyXIFYXAE"]["mJrNNSTbIbzTlGvlvjVrHExnYb"].stringValue
            let orderNo = productData["ZtPGSuqZrjKpnehiiyXIFYXAE"]["IcaNJhXEiHypHwDBRNBhzXOMDTfvch"].stringValue
            Applyed.productPush(amount: amount,orderNo: orderNo)
        }else{
            Applyed.nextStep(step: nextPath)
        }
        
    }
  
    

}
