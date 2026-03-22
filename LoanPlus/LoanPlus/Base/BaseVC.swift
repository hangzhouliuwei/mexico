//
//  BaseVC.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//


class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    var navBarHidden = false
    var pushRemove = false
    override var title:String? {
        didSet {
            setTitle(title: title!)
        }
    }
    var isPresented: Bool {
        return presentingViewController != nil
    }
    lazy var navBar = lazyNavigationBar()
    lazy var contentView = lazyContentView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        navigationController?.isNavigationBarHidden = true
        navBar.isHidden = navBarHidden
//        super.edgesForExtendedLayout = UIRectEdge.init(rawValue: 4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    func contentVeiwHeight() -> Double{
        var height = ScreenHeight;
        if (!navBarHidden) {
            height -= NavBarHeight;
        }
        if (tabBarController != nil) {
            height -= TabBarHeight;
        }
        return height;
    }
    
    func lazyNavigationBar() -> BaseNavBar {
        let bar = BaseNavBar(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: NavBarHeight))
        bar.backgroundColor = UIColor.white
        bar.backBlock = {[weak self] in
            self?.back()
        }
        
        view.addSubview(bar)
        return bar
    }
    
    func lazyContentView() -> BaseContainer {
        let startY = navBarHidden ? 0 : NavBarHeight;
        let content = BaseContainer(frame: CGRect(x: 0, y: startY, width: view.frame.size.width, height: contentVeiwHeight()))
        content.backgroundColor = .bg
        view.addSubview(content)
        return content
    }
    
    func setTitle(title:String){
        navBar.titleLabel.text = title
    }
    
    func back() {
        if isPresented {
            self.dismiss(animated: true)
        } else {
            Page.pop(animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

class BaseContainer: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func fitView(view:UIView) {
        self.contentSize = CGSize(width: self.width, height: max(view.bottom + SafeBottomHeight, self.height + 1));
    }
}

class BaseNavBar: UIView {
    
    lazy var leftBtn = lazyLeftBtn()
    lazy var titleLabel = lazyTitleLabel()
    lazy var rightBtn = lazyRightBtn()
    var backBlock :VoidBlock?
    var rightItemBlock :VoidBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUI() {
        leftBtn.isHidden = false
//        addLine(position: .bottom, color: .lightMain)
    }

    func lazyLeftBtn() -> UIButton {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 5, y: StatusBarHeight, width: 44, height: 44)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "page_back_black"), for: .normal)
        btn.addTarget(self, action: #selector(leftBtnAction), for: .touchUpInside)
        addSubview(btn)
        return btn
    }
    
    func lazyTitleLabel() -> UILabel {
        let title = UILabel(frame: CGRect(x: 5.0 + 44, y: StatusBarHeight, width: ScreenWidth - 10.0 - 44*2, height: 44))
        title.textColor = .textBlack
        title.font = .fontBold(16)
        title.textAlignment = .center
        addSubview(title)
        return title
    }
    
    func lazyRightBtn() -> UIButton {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: ScreenWidth - 80 - LeftMargin, y: StatusBarHeight, width: 80, height: 44)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(.main, for: .normal)
        btn.setTitle("", for: .normal)
        btn.contentHorizontalAlignment = .right
        btn.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
        addSubview(btn)
        return btn
    }
    
    @objc func leftBtnAction() {
        if (backBlock != nil) {
            backBlock!()
        }
    }
    
    @objc func rightBtnAction() {
        if (rightItemBlock != nil) {
            rightItemBlock!()
        }
    }
    
    func setTitle(title:String) {
        titleLabel.text = title
    }
    
    func setLeftTitle(title:String) {
        leftBtn.setTitle(title, for: .normal)
    }
    
    func setRightTitle(title:String) {
        rightBtn.setTitle(title, for: .normal)
    }
    
    func showRightItem() {
        rightBtn.isHidden = false
    }
    
    func hideRightItem() {
        rightBtn.isHidden = true
    }
}
