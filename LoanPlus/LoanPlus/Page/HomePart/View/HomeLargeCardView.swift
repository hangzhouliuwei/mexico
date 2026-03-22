//
//  HomeLargeCardView.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/11/26.
//

import Foundation
import JJCarouselView

class HomeLargeCardView:UIView {
    
    var  iconImageView:UIImageView!
    var  titleLabel:UILabel!
    var  bellImageView:UIImageView!
    
    var  bellImageViewButton:UIButton!

    var  amountLabel:UILabel!
    var  termsInfo:LoanPeriodView!
    var  rateinfo:LoanPeriodView!
    
    var gradientButton: GradientButton!
    
    var loanData:JSON?
    let carouselView: JJCarouselView<UIImageView, JSON> = JJCarouselView(frame: CGRect.zero)
    var productID:String?
    
    func loadTheSubViewWithData(data:JSON) {
        
        bellImageView.kf.setImage(with: URL(string:data["FbUPTGXUjMhIqbEkr"]["NRNNcRDtfvDRIJrpZlHMmTCxESgJ"].stringValue))
        bellImageViewButton.addTap {
            Applyed.jumpCheck(path: data["FbUPTGXUjMhIqbEkr"]["nuNPFyFwElymqjZriEqjyEJ"].stringValue)
        }
        
        
        
        
        let homeArray = data["JucvBgeXWOYVjsOsUU"].arrayValue
        for homeItem in  homeArray{
            if homeItem["MxpNpYKadDRvmjqybUjsIEARDwIwW"] == "CASHRAP_ONE" {
                let bannerArray = homeItem["AKDaQpLIziPsAlUT"].arrayValue
                DispatchQueue.main.async {
                    self.carouselView.datas = bannerArray;
                    self.carouselView.config.display = { cell , object in
                        cell.kf.setImage(with: URL(string: object["gVoocmDLzkfZUjKLMnAlZIakEQjc"].stringValue))
                        cell.isUserInteractionEnabled = true
                        cell.addTap {
                            Applyed.jumpCheck(path: object["QMhNOYRoRAAQmsLJAMkjm"].stringValue)
                            
                        }
                    }
                    self.carouselView.layoutSubviews()
                }
               

            
               
            }else
            if homeItem["MxpNpYKadDRvmjqybUjsIEARDwIwW"] == "CASHRAP_TWO" {
                titleLabel.text = homeItem["AKDaQpLIziPsAlUT"]["yHCFirltgULKFkAByv"].stringValue
                amountLabel.text = homeItem["AKDaQpLIziPsAlUT"]["OnGNMpKrMTODiIJQukjAqi"].stringValue
                
                termsInfo.mainLabel.text = homeItem["AKDaQpLIziPsAlUT"]["RpxpYhfYznvEWVsAqaZ"].stringValue
                
                rateinfo.mainLabel.text = homeItem["AKDaQpLIziPsAlUT"]["ZwAbePBmmdUjtpNpwMVkjRp"].stringValue

                iconImageView.kf.setImage(with: URL(string: homeItem["AKDaQpLIziPsAlUT"]["vIpWhjneVpwTdpCtkKiZZvcpkZDPUR"].stringValue))
                gradientButton.setTitle(homeItem["AKDaQpLIziPsAlUT"]["ACxCbolvnPQnuoNMSJrQpIMKxtY"].stringValue, for: .normal)
        
                productID = homeItem["AKDaQpLIziPsAlUT"]["aCKZvqNkalWGvsBlvdfEMrZPWfkPB"].stringValue
            }
            
            
            
        }

        
    }
    
  
    
    @objc func loanApplyTapped()
    {
        if UserM.isLogin(){
            Applyed.applyNow(id: productID ?? "")
        }
        
    }

    
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
        setupCertificationProcessView()
        let rasie = UIImageView(image: UIImage(named: "img_home_3d"))
        addSubview(rasie);
        rasie.snp.makeConstraints { make in
            make.trailing.equalTo(-29);
            make.top.equalTo(self.snp.top).offset(137);
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
        
        
        iconImageView = UIImageView(image: UIImage(systemName: "creditcard.fill"))
        
        headerView.addSubview(iconImageView)
        
        titleLabel = UILabel()
        titleLabel.text = "Los nombres"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(titleLabel)
        
         bellImageView = UIImageView(image: UIImage(named: "ic_kefu"))
        headerView.addSubview(bellImageView)
        bellImageView.isUserInteractionEnabled = true;
        bellImageViewButton = UIButton(type: .custom)
        bellImageView.addSubview(bellImageViewButton)

        
        
        carouselView.config.autoLoop = true
        carouselView.config.loopTimeInterval = 5
        carouselView.config.contentInset = .zero
        
        
  
        
        headerView.addSubview(carouselView);

        
        
        carouselView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.bottom.equalTo(0);
            make.width.equalTo(288);
            make.height.equalTo(64)
        }
        
       
        
        
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(140)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.size.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.centerY.equalTo(iconImageView)
        }
        
        bellImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(titleLabel);
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
        
        let iconBgImageView = UIImageView(image: UIImage(named: "bg_home_card"))
        loanInfoView.addSubview(iconBgImageView)
        iconBgImageView.snp.makeConstraints { make in
            make.edges.equalTo(0);
        }
        
        
        
        
        let loanLabel = UILabel()
        loanLabel.text = "Monto del préstamo"
        loanLabel.font = .systemFont(ofSize: 16, weight: .medium)
        loanLabel.textColor = .white
        loanInfoView.addSubview(loanLabel)
        
         amountLabel = UILabel()
        amountLabel.text = "$1,000–20,000"
        amountLabel.font = .systemFont(ofSize: 24, weight: .bold)
        amountLabel.textColor = .white
        loanInfoView.addSubview(amountLabel)
        
        
        
        
        
        termsInfo = LoanPeriodView(mainText: "180 días", subText: "Plazo de préstamo", type: 0)
        loanInfoView.addSubview(termsInfo)
        
        
         rateinfo = LoanPeriodView(mainText: "0.05% día", subText: "Tasa de Interés", type: 1)
        
        loanInfoView.addSubview(rateinfo)
        
        
        // 创建按钮
         gradientButton = GradientButton()
        gradientButton.setTitle("Conseguir Mi Préstamo", for: .normal)
        loanInfoView.addSubview(gradientButton)

        
        
        let button = UIButton()
        button.addTarget(self, action: #selector(loanApplyTapped), for: .touchUpInside)
        loanInfoView.addSubview(button)
        
        
        
        loanInfoView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(140 + 30)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(308)
        }
        
        
        loanLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview().inset(30);
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(loanLabel.snp.bottom).offset(10)
            make.leading.equalTo(loanLabel)
        }
        
        termsInfo.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalTo(loanInfoView.snp.centerX).offset(-5)
            make.height.equalTo(54)
        }
        
        rateinfo.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalTo(loanInfoView.snp.centerX).offset(5)
            make.height.equalTo(54)
        }
        // 使用 SnapKit 添加约束
        gradientButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50) // 高度固定
            make.width.greaterThanOrEqualTo(250) // 宽度至少200
            make.bottom.equalTo(-30)
        }
        button.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    // MARK: - Certification Process View
    private func setupCertificationProcessView() {
        let certificationLabel = GradientLabel()
        certificationLabel.text = "Certification Process"
        addSubview(certificationLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        addSubview(stackView)
        
        let steps = ["Enviar información", "Activar", "Obtener dinero"]
        let icons = ["ic_message", "ic_activate", "ic_money"]
        
        for (index, step) in steps.enumerated() {
            let stepView = UIView()
            
            let icon = UIImageView(image: UIImage(named: icons[index]))
            stepView.addSubview(icon)
            
            
            
            let label = UILabel()
            label.text = step
            label.font = .systemFont(ofSize: 12)
            label.textAlignment = .center
            label.numberOfLines = 2
            stepView.addSubview(label)
            
            let arrow = UIImageView(image: UIImage(named: "bg_home_3"))
            stepView.addSubview(arrow)
            
            icon.snp.makeConstraints { make in
                make.top.equalTo(0)
                make.size.equalTo(40)
                make.centerX.equalToSuperview()
            }
            
            label.snp.makeConstraints { make in
                make.top.equalTo(icon.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview()
                make.width.equalTo(77)
            }
            arrow.snp.makeConstraints { make in
                make.left.equalTo(icon.snp.right).offset(10)
                make.centerY.equalTo(icon)
                make.width.equalTo(14)
                make.height.equalTo(26)
            }
            
            
            stackView.addArrangedSubview(stepView)
        }
        
        certificationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(500)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(200)
            
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(certificationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        
        let bg_home_botton = UIImageView(image: UIImage(named: "bg_home_bootom"))
        
        addSubview(bg_home_botton)
        bg_home_botton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(115)
        }
        

        
        
        
        
    }
}





class LoanPeriodView: UIView {
    
    var type = 0;
    // 图标视图
    public let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_time")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // 主标题标签
    public let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "180 días"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    public let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Plazo de préstamo"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // 初始化方法，带参数
    init(mainText: String, subText: String, type:Int) {
        super.init(frame: .zero)
        setupView()
        configure(mainText: mainText, subText: subText, type: type)
    }
    private func configure(mainText: String, subText: String,type:Int) {
        mainLabel.text = mainText
        subLabel.text = subText
        if type != 0 {
            iconImageView.image = UIImage(named: "ic_rate")
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    
    
    private func setupView() {
        // 设置背景颜色和圆角
        self.backgroundColor = UIColor(hex: "#7787EA")
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        // 添加子视图
        addSubview(iconImageView)
        addSubview(mainLabel)
        addSubview(subLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview().offset(3);
            make.height.equalTo(24)
        }
        // 添加约束
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(mainLabel.snp.leading).offset(-3)
            make.size.equalTo(24) // 图标大小
        }
        
        
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
}


class BannerView:UIView {
    
    let bannerView = UIImageView()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView()
    {
        bannerView.isUserInteractionEnabled = true
        addSubview(bannerView)
        
    
    }
    
}









