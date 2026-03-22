//
//  CertBaseVC.swift
//  LoanPlus
//
//  Created by Kiven on 2024/11/28.
//

import UIKit

class CertBaseVC: UIViewController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {
    
    var certType:CertType
    var pushRemove = true
    var inTime = ""
    
    var isDone = false
    
    var productId = Applyed.productId
    
    init(certType: CertType) {
        self.certType = certType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if pushRemove {
            if let navigationController = self.navigationController,
               !navigationController.viewControllers.contains(self) {
                return
            }
            if let navigationController = self.navigationController {
                navigationController.viewControllers.removeAll { $0 === self }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.delegate = nil
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self{
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        backClick()
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        inTime = String.nowTimeString()
        view.backgroundColor = .lightMain
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        navigationController?.isNavigationBarHidden = true
        navigationController?.delegate = self
        
        setUI()
    }
    
    func riskInfo(_ type:String) {
        AppTrack.riskInfo(type, inTime, productId)
    }
    
    func setUI(){
        
        footView.addSubview(nextLable)
        
        if self.certType == .credit{
            headView = creditHeadView()
            view.addSubview(headView)
            headView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(ScreenWidth/375*156+NavBarHeight)
            }
            
        }else{
            view.addSubview(headView)
            headView.addSubview(headBgimg)
            headView.addSubview(titleImg)
            headView.addSubview(backBtn)
            
            switch self.certType {
            case .pub:
                headBgimg.image = UIImage(named: "cert_head01")
                titleImg.image = UIImage(named: "cert_title_credit")
            case .personal:
                headBgimg.image = UIImage(named: "cert_head02")
                titleImg.image = UIImage(named: "cert_title personal")
            case .job:
                headBgimg.image = UIImage(named: "cert_head03")
                titleImg.image = UIImage(named: "cert_title_job")
            case .ext:
                headBgimg.image = UIImage(named: "cert_head04")
                titleImg.image = UIImage(named: "cert_title_ext")
            case .bank:
                headBgimg.image = UIImage(named: "cert_head05")
                titleImg.image = UIImage(named: "cert_title_bank")
            default :return
            }
            
            headView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(ScreenWidth/375*190)
            }
            headBgimg.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            backBtn.setImage(UIImage(named: "page_back_white"), for: .normal)
            backBtn.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(0)
                make.top.equalToSuperview().offset(12+StatusBarHeight)
                make.size.equalTo(CGSize(width: 44, height: 44))
            }
            titleImg.snp.makeConstraints { make in
                make.top.equalTo(backBtn.snp.bottom).offset(-4)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 236, height: 28))
            }
            
            footView.addSubview(notisView)
            notisView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.bottom.equalTo(nextLable.snp.top)
            }
            
        }
        view.addSubview(contentView)
        view.addSubview(footView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(-20)
            make.bottom.equalTo(footView.snp.top)
        }
        
        let footHei = 70 + (self.certType == .pub ? 54 : 0)
        footView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(footHei)
        }
        nextLable.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        
    }
    
    lazy var headView:UIView = {
        let headView = UIView()
        headView.backgroundColor = .clear
        return headView
    }()
    
    lazy var contentView:UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    lazy var footView:UIView = {
        let footView = UIView()
        footView.backgroundColor = .clear
        return footView
    }()
    
    lazy var headBgimg:UIImageView = {
        let headBgimg = UIImageView()
        return headBgimg
    }()
    
    lazy var titleImg:UIImageView = {
        let titleImg = UIImageView()
        return titleImg
    }()
    
    lazy var backBtn:UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "page_back_white"), for: .normal)
        backBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        return backBtn
    }()
    
    func creditHeadView() -> UIView{
        let headView = UIView()
        headView.backgroundColor = .clear
        
        let topview = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: NavBarHeight))
        topview.backgroundColor = .white
        headView.addSubview(topview)
        
        let titleLab = UILabel.create(text: "Certificación de información", textColor: .textBlack, font: .fontBold(16))
        titleLab.textAlignment = .center
        topview.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-11)
            make.height.equalTo(22)
        }
        
        backBtn.setImage(UIImage(named: "page_back_black"), for: .normal)
        topview.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalTo(titleLab)
            make.size.equalTo(CGSize(width: 14, height: 28))
        }
        
        let header = UIImageView(frame: CGRect(x:0, y: NavBarHeight, width: ScreenWidth, height: 156.w))
        header.image = UIImage(named: "survey_header")
        headView.addSubview(header)
        
        let descString = "Participa en el cuestionario en 15 segundos \ny obtén un monto de préstamo mayor!"
        let title = UILabel(frame: CGRect(x: 20, y: 55.w+NavBarHeight, width: 275.w, height: 75.w))
        title.textColor = .init(hex: 0x001062, alpha: 0.6)
        title.font = .fontBold(14)
        title.numberOfLines = 0
        title.text = descString
        title.setTextWithColor("15 segundos", color: .init(hex: 0x001062))
        headView.addSubview(title)
        
       
        
        return headView
    }
    
    //MARK: - backClick
    @objc func backClick(){
        print("-- Log -- backClick")
        if !isDone{
            let stayAlertView = StayAlertView()
            stayAlertView.sureClick = {
                self.closeVC()
            }
            UIApplication.shared.windows.first?.addSubview(stayAlertView)
        }else{
            closeVC()
        }
        
    }
    
    func closeVC(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true)
        } else {
            Page.pop(animated: true)
        }
    }
    
    
    lazy var notisView:UIView = {
        return notiView()
    }()
    
    func notiView() ->UIView{
        let notisView = UIView()
        notisView.isHidden = self.certType != .pub
        notisView.backgroundColor = .clear
        
        let notiImg = UIImageView()
        notiImg.image = UIImage(named: "cert_noti")
        notisView.addSubview(notiImg)
        
        let notiLab = UILabel.create(text: "Tips: ID card with a clear photo will increase the approval rate", textColor: UIColor(r: 102, g: 102, b: 102), font: .font(13))
        notiLab.numberOfLines = 0
        notisView.addSubview(notiLab)
        
        notiImg.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        notiLab.snp.makeConstraints { make in
            make.left.equalTo(notiImg.snp.right).offset(6)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        return notisView
    }
    
    private lazy var nextLable:UILabel = {
        let nextLable = UILabel()
        nextLable.font = UIFont.systemFont(ofSize: 18)
        nextLable.text = "Solicitar"
        nextLable.textColor = .white
        nextLable.backgroundColor = .black
        nextLable.textAlignment = .center
        nextLable.cornerRadius = 25
        let tpas = UITapGestureRecognizer(target: self, action: #selector(nextClick))
        nextLable.isUserInteractionEnabled = true
        nextLable.addGestureRecognizer(tpas)
        return nextLable
    }()

    //MARK: - nextClick
    @objc func nextClick(){
        print("-- Log -- nextClick")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextLable.textColor = UIColor(patternImage: UIImage.getGradientImage(size: nextLable.bounds.size))
    }
    
    public func hideNext(ishidden:Bool = true){
        nextLable.isHidden = ishidden
        let height = ishidden ? 0 : (70 + (self.certType == .pub ? 54 : 0))
        footView.snp.remakeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }
    

}
