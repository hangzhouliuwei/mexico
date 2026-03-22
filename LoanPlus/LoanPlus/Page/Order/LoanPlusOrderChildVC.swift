//
//  LoanPlusOrderChildVC.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/12/3.
//

import UIKit
import JXSegmentedView
import SnapKit
import MJRefresh


class LoanPlusOrderChildVC:  BaseVC {
    var tabTitle: String
    var type = "7"
    var dataArray = [JSON]()


    init(title: String) {
        self.tabTitle = title
        super.init()
        navBarHidden = true
    
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            
            make.height.equalTo(400)
        }
        setupRefreshControl()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UserM.isLogin(){
            UserM.login()
            return;
        }
        
        loadConfigData()
    }
    
    
    
    func setupRefreshControl() {
            // 下拉刷新
            tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        }
    
    @objc func refreshData() {
         // 模拟网络请求，刷新数据
         DispatchQueue.main.asyncAfter(deadline: .now()) {
             self.loadConfigData()
             
         }
     }
    
    func loadConfigData(){
        Network.post(path: .orderTypeList, parameters: ["kVnKPEfhAHaCgdYFPtnjraGO":self.type,"UgvXlaHgvHWWFtrTgBGQAR":"1","FXhqEuedyjIOWsk":"1000","EcFatOsbFuxHhtj":"EcFatOsbFuxHhtj"]) { [self] res, error in
            
            tableView.mj_header?.endRefreshing()
            dataArray.removeAll()

            dataArray = res.data["JucvBgeXWOYVjsOsUU"].arrayValue
            
            if dataArray.count > 0 {
                emptyView.isHidden = true;
                tableView.isHidden = false
            }else {
                emptyView.isHidden = false;
                tableView.isHidden = true
            }
            
            tableView.reloadData()
            
            
            
        }
    }
    
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    lazy var emptyView: OrderEmptyTipsView = {
        let emptyView = OrderEmptyTipsView()
        emptyView.isHidden = false
        return emptyView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(hex: "#EBF2FF")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160;
        tableView.layer.cornerRadius = 20
        tableView.register(LoanOerderCell.self, forCellReuseIdentifier: LoanOerderCell.className)
        return tableView
    }()
    

}

extension LoanPlusOrderChildVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LoanOerderCell(style: .default, reuseIdentifier: LoanOerderCell.className)
        let orderCellDetail = dataArray[indexPath.row]
        cell.loadTheSubViewWithData(data: orderCellDetail)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderCellDetail = dataArray[indexPath.row]

        Applyed.jumpCheck(path: orderCellDetail["hJeUdrIJeTWitkCYNv"].stringValue)
    }
    
}


extension LoanPlusOrderChildVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
}


class OrderEmptyTipsView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView () {
        
        // place holder
        let imageView = UIImageView()
        imageView.image = UIImage(named: "order_5")
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(60)
            make.size.equalTo(189)
            
        }
        
        // tips
        let messageLabel = UILabel()
        messageLabel.text = "No hay más conenido.\nvaya a solicitar más préstamos."
        messageLabel.textColor = UIColor.darkGray
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(70)
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
        
        // 按钮
        let solicitarButton = UIButton(type: .system)
        solicitarButton.setTitle("Solicitar", for: .normal)
        solicitarButton.setTitleColor(.white, for: .normal)
        solicitarButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        solicitarButton.backgroundColor = UIColor.black
        solicitarButton.layer.cornerRadius = 25
        solicitarButton.addTarget(self, action: #selector(solicitarButtonTapped), for: .touchUpInside)
        addSubview(solicitarButton)

        solicitarButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(messageLabel.snp.bottom).offset(5)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        
        
        
        
    }
    
    @objc private func solicitarButtonTapped() {
        // 跳转到首页
        Page.switchTabBar(index: 0)
        

    }
    
    
}
