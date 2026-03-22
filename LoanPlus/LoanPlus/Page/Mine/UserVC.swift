//
//  UserVC.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//

import UIKit
import SnapKit
import MJRefresh
import Kingfisher

class UserVC: BaseVC {
    
    let phoneLabel = UILabel()
    
    let maxView = UIView()
    
    var userCenterArray:[JSON]?
    
    let bottomStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshControl()
        
        
    }
    func setupRefreshControl() {
            // 下拉刷新
            contentView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
            
            
        }
    
    @objc func refreshData() {
         // 模拟网络请求，刷新数据
         DispatchQueue.main.asyncAfter(deadline: .now()) {
             self.loadConfigData()
             
         }
     }
    
    func loadConfigData(){
        Network.post(path: .userCenter) { [self] res, error in
            self.contentView.mj_header?.endRefreshing() // 结束刷新
            print(res.data)
            let array = res.data["extendList2"].arrayValue
            userCenterArray = array
            relodaTheUI()
            
            
            
            
            
        }
    }
    
    private func relodaTheUI() {
        for items in bottomStackView.arrangedSubviews
        {
            items.removeFromSuperview()
        }
        
        var i = 0
        for item in userCenterArray!
        {
            let title = item["mKsoYNXaLHQHofdNQlnVFTaLyD"].stringValue
            let logo = item["FbUPTGXUjMhIqbEkr"].stringValue
            let path = item["QMhNOYRoRAAQmsLJAMkjm"].stringValue
            i += 1
            
            let itemView = createListItem(icon: logo, title: title, index: i, path: path)
            bottomStackView.addArrangedSubview(itemView)

        }
 
        bottomStackView.snp.updateConstraints { make in
            make.height.equalTo((userCenterArray?.count ?? 0) * 70)
        }
        phoneLabel.text =  UserM.phone
    }
    

    private func setupUI() {
        contentView.addSubview(maxView);
        maxView.backgroundColor = UIColor(hex: "#EBF2FF")

        maxView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            
        }
        
        // 顶部钱包视图
        let headerView = UIImageView(image: UIImage(named: "user_icon"))
        headerView.isUserInteractionEnabled = true;
        maxView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.right.equalToSuperview().inset(0)
            make.height.equalTo(450)
        }
        
        
        let walletImageView = UIImageView(image: UIImage(named: "img_touxiang"))
        walletImageView.contentMode = .scaleAspectFit
        headerView.addSubview(walletImageView)
        walletImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        
        phoneLabel.text = ""
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 20)
        phoneLabel.textAlignment = .center
        maxView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(walletImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        // 中部订单注册视图
        let orderView = UIImageView(image: UIImage(named: "user_icon_6"))
        orderView.isUserInteractionEnabled = true
        maxView.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.top.equalTo(maxView.snp.top).offset(200)
            make.left.right.equalToSuperview().inset(0)
            make.height.equalTo(225)
        }
        
        let orderTitle = UILabel()
        orderTitle.text = "Registro de pedidos"
        orderTitle.font = UIFont.systemFont(ofSize: 16)
        orderTitle.textColor = .white
        orderView.addSubview(orderTitle)
        orderTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(30)
            make.height.equalTo(21)
        }
        
        let iconStackView = UIStackView()
        iconStackView.axis = .horizontal
        iconStackView.distribution = .fillProportionally
        iconStackView.spacing = 0
        
        orderView.addSubview(iconStackView)
        iconStackView.snp.makeConstraints { make in
            make.top.equalTo(orderView.snp.top).offset(30)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(130)
        }
        
        // 图标和标题
        let items = [
            ("user_icon_2", "En proceso >", 1),
            ("user_icon_3", "Préstamos >", 2),
            ("user_icon_4", "Pagados >",3)
        ]
        
        for (iconName, title, type) in items {
            let itemView = createIconView(icon: iconName, title: title, type: type)
            iconStackView.addArrangedSubview(itemView)
        }
        

        // 底部功能列表
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillProportionally
        bottomStackView.spacing = 30
        bottomStackView.backgroundColor = UIColor(hex: "#EBF2FF")
        maxView.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(orderView.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(3 * 70)
        }
        
        maxView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomStackView.snp.bottom).offset(230)
        }
        
        
    
        contentView.fitView(view: maxView)
        
    }
    
    private func createIconView(icon: String, title: String, type:Int) -> UIView {
        let container = UIView()
        
        
        let imageView = UIImageView(image: UIImage(named: icon))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        container.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(23)
            make.centerX.equalToSuperview()
            make.size.equalTo(38)
        }
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.centerX.bottom.equalToSuperview()
        }
        
        container.addTap { [self] in
            clickTheOrderInput(type: type)
        }
        
        return container
    }
    
    private func clickTheOrderInput(type:Int) {
        //jump to order
        
        let orderVc = LoanPlusOrderVC();
        orderVc.currrentIndex = type
        Page.push(vc: orderVc, animated: true)
        
        
        
        
    }
    
    private func createListItem(icon: String, title: String, index:Int, path:String ) -> UIView {
        let container = UIView()
        
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
    
        iconView.kf.setImage(with: URL(string: icon))
        container.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .fontMedium(14)
        titleLabel.textColor = .black
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-36)
        }
        let rightArrowView = UIImageView(image: UIImage(named: "Combined Shape"))
        rightArrowView.contentMode = .scaleAspectFit
        container.addSubview(rightArrowView)
        rightArrowView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        
        container.backgroundColor = .white
        
        container.layer.masksToBounds = true;
        container.layer.cornerRadius  = 12;
        container.addTap {
            Applyed.jumpCheck(path: path)
        }
        
        
      
   
        
        return container
    }
    
    override func contentVeiwHeight() -> Double {
        return ScreenHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadConfigData()
    }
    
    
}
