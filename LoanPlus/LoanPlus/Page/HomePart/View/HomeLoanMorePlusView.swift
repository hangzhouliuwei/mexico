//
//  HomeLoanMorePlusView.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/11/26.
//

import UIKit
import SnapKit
import JJCarouselView

class HomeLoanMorePlusView: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    
    var  bellImageView:UIImageView!
    
    var  bellImageViewButton:UIButton!

    var  iconImageView:UIImageView!
    
    var  titleLabel:UILabel!
    
    var  amountLabel:UILabel!
    let carouselView: JJCarouselView<UIImageView, JSON> = JJCarouselView(frame: CGRect.zero)
    var gradientButton = GradientButton()
    var applyButton = UIButton()

    var loanData:JSON?
    
    var productID:String?

    
    
    func loadTheSubViewWithData(data:JSON) {
        
        bellImageView.kf.setImage(with: URL(string:data["FbUPTGXUjMhIqbEkr"]["NRNNcRDtfvDRIJrpZlHMmTCxESgJ"].stringValue))
        bellImageViewButton.addTap {
            Applyed.jumpCheck(path: data["FbUPTGXUjMhIqbEkr"]["nuNPFyFwElymqjZriEqjyEJ"].stringValue)
        }
        dataArray.removeAll()
        let homeArray = data["JucvBgeXWOYVjsOsUU"].arrayValue
        for homeItem in  homeArray{
            if homeItem["MxpNpYKadDRvmjqybUjsIEARDwIwW"] == "CASHRAP_ONE" {
                let bannerArray = homeItem["AKDaQpLIziPsAlUT"].arrayValue
                
                carouselView.datas = bannerArray;
                DispatchQueue.main.async {
                    
               
                    self.carouselView.config.display = { cell , object in
                    cell.kf.setImage(with: URL(string: object["gVoocmDLzkfZUjKLMnAlZIakEQjc"].stringValue))
                    cell.isUserInteractionEnabled = true
                    cell.addTap {
                        Applyed.jumpCheck(path: object["QMhNOYRoRAAQmsLJAMkjm"].stringValue)
                        
                    }
                }
                    self.carouselView.layoutSubviews()
                }
            
               
            }else if homeItem["MxpNpYKadDRvmjqybUjsIEARDwIwW"] == "CASHRAP_THREE" {
                titleLabel.text = homeItem["AKDaQpLIziPsAlUT"]["yHCFirltgULKFkAByv"].stringValue
                amountLabel.text = homeItem["AKDaQpLIziPsAlUT"]["OnGNMpKrMTODiIJQukjAqi"].stringValue
                

                iconImageView.kf.setImage(with: URL(string: homeItem["AKDaQpLIziPsAlUT"]["vIpWhjneVpwTdpCtkKiZZvcpkZDPUR"].stringValue))
                gradientButton.setTitle(homeItem["AKDaQpLIziPsAlUT"]["ACxCbolvnPQnuoNMSJrQpIMKxtY"].stringValue, for: .normal)
        
                productID = homeItem["AKDaQpLIziPsAlUT"]["aCKZvqNkalWGvsBlvdfEMrZPWfkPB"].stringValue
                gradientButton.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
                
                applyButton.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
                
            }else if  homeItem["MxpNpYKadDRvmjqybUjsIEARDwIwW"] == "CASHRAP_FOUR" {
                
                
                let product_quick_Array = homeItem["AKDaQpLIziPsAlUT"].arrayValue;
                dataArray = product_quick_Array;
                self.moreLoanTableView.reloadData()
                self.moreLoanTableView.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(105+213)

                    make.height.equalTo(160 * product_quick_Array.count)
                }
                
                
                
                
            }
            
            
        }
        
        
        
        
        
        
        
        
        
    }
    @objc func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if UserM.isLogin(){
                Applyed.applyNow(id: self.productID ?? "")
            }
        }
    }
    
    
    let moreLoanTableView = UITableView()
    
    var dataArray = [JSON]()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    
    func setUpView() {
        
        // 设置视图
        setupHeaderView()
        setupMainContentView()
        setupBottomTableView()
        let rasie = UIImageView(image: UIImage(named: "img_home_3d"))
        addSubview(rasie);
        rasie.snp.makeConstraints { make in
            make.trailing.equalTo(-30);
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(56);
            make.width.equalTo(116);
            make.height.equalTo(121);
        }
        
        
    }
    
    // MARK: - Header View
    private func setupHeaderView() {
        let iconBgImageView = UIImageView(image: UIImage(named: "bg_home"))
        addSubview(iconBgImageView)
        iconBgImageView.snp.makeConstraints { make in
            make.edges.equalTo(0);
        }
        let headerView = UIView()
        addSubview(headerView)
        
        
        
        
       
        
        bellImageView = UIImageView(image: UIImage(named: "ic_kefu"))
       headerView.addSubview(bellImageView)
       bellImageView.isUserInteractionEnabled = true;
       bellImageViewButton = UIButton(type: .custom)
       bellImageView.addSubview(bellImageViewButton)
        
    
        carouselView.config.autoLoop = true
        carouselView.config.loopTimeInterval = 5
        carouselView.config.contentInset = .zero
    
        headerView.addSubview(carouselView);

    
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(91)
        }
        
        carouselView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.bottom.equalTo(0);
            make.width.equalTo(288);
            make.height.equalTo(64)
        }
        
        bellImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(headerView.safeAreaLayoutGuide.snp.top).offset(20);
            make.size.equalTo(24)
        }
        
        bellImageViewButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(0);
        }
    }
    
    // MARK: - Main Content View
    private func setupMainContentView() {
        
        let loanInfoView = UIView()
        
        loanInfoView.layer.cornerRadius = 16
        addSubview(loanInfoView)
        
        let iconBgImageView = UIImageView(image: UIImage(named: "bg_home_card3"))
        loanInfoView.addSubview(iconBgImageView)
        iconBgImageView.snp.makeConstraints { make in
            make.edges.equalTo(0);
        }
        
        iconImageView = UIImageView()
        loanInfoView.addSubview(iconImageView)
        
        titleLabel = UILabel()
        titleLabel.text = "Los nombres"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        loanInfoView.addSubview(titleLabel)
        
        
        let loanLabel = UILabel()
        loanLabel.text = "Monto del préstamo"
        loanLabel.font = .systemFont(ofSize: 16, weight: .medium)
        loanLabel.textColor = .white
        loanInfoView.addSubview(loanLabel)
        
        amountLabel = UILabel()
        amountLabel.text = "$20,000"
        amountLabel.font = .systemFont(ofSize: 24, weight: .bold)
        amountLabel.textColor = .white
        loanInfoView.addSubview(amountLabel)
        
        
        
        
        let applyDescLabel = UILabel()
        applyDescLabel.text = "Ayuda a resolver sus problemas de dinero"
        applyDescLabel.font = .systemFont(ofSize: 13, weight: .regular)
        applyDescLabel.textColor = .white
        loanInfoView.addSubview(applyDescLabel)
      
        
        
        // 创建按钮
        gradientButton.setTitle("Conseguir Mi Préstamo", for: .normal)
        loanInfoView.addSubview(gradientButton)
        
        loanInfoView.addSubview(applyButton)
        
        
        
        
        loanInfoView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(105)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(213)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(24);
            make.top.equalTo(7);
            make.size.equalTo(24);
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(5);
            make.centerY.equalTo(iconImageView);
        }
        
        
        loanLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(51)
            make.leading.equalToSuperview().inset(30);
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(loanLabel.snp.bottom).offset(10)
            make.leading.equalTo(loanLabel)
        }
        applyDescLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(10)
            make.leading.equalTo(loanLabel)
        }
        
       
        // 使用 SnapKit 添加约束
        gradientButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50) // 高度固定
            make.width.greaterThanOrEqualTo(250) // 宽度至少200
            make.bottom.equalTo(-5)
        }
        
        applyButton.snp.makeConstraints { make in
            make.left.top.bottom.right.equalTo(0)
        }
        
        
        
    }
    private func setupBottomTableView() {
        moreLoanTableView.backgroundColor = .clear
        moreLoanTableView.isScrollEnabled = false
        moreLoanTableView.delegate = self
        moreLoanTableView.dataSource = self
        moreLoanTableView.register(HomeLoanMorePlusViewCell.self, forCellReuseIdentifier: "HomeLoanMorePlusViewCell")
        moreLoanTableView.rowHeight = UITableView.automaticDimension
        moreLoanTableView.estimatedRowHeight = 140;
        
        addSubview(moreLoanTableView)
        
        moreLoanTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(105+213)
            make.height.equalTo(0);
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeLoanMorePlusViewCell", for: indexPath) as! HomeLoanMorePlusViewCell
        cell.loadTheSubViewWithData(data: dataArray[indexPath.row])
         
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
       let productItem =  dataArray[indexPath.row]
        
        if UserM.isLogin(){
            Applyed.applyNow(id: productItem["aCKZvqNkalWGvsBlvdfEMrZPWfkPB"].stringValue)
        }
    }
    
    

}



