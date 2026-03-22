//
//  LoanPlusOrderVC.swift
//  LoanPlus
//
//  Created by 许广会 on 2024/12/3.
//

import UIKit
import JXSegmentedView

class LoanPlusOrderVC: BaseVC{
    
    var segmentedSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listView: JXSegmentedListContainerView!
    var titles: [String] = ["Todos", "En proceso", "Préstamos", "Pagados"]
    var currrentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registro de pedidos"
        initData(self, titles: titles)
        navBarHidden = false
        
    }
    func initData(_ vc: BaseVC, titles: [String], frame: CGRect = .init(x: 0, y: NavBarHeight, width: ScreenWidth, height: 40)) {
        view.backgroundColor = .white
        segmentedView = JXSegmentedView()
        segmentedView.backgroundColor = .white
        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedSource = JXSegmentedTitleDataSource()
        segmentedSource.titles = titles
        segmentedSource.isTitleColorGradientEnabled = true
        segmentedView.dataSource = segmentedSource
        segmentedSource.titleSelectedColor = .black
        segmentedSource.titleNormalColor = .gray
        segmentedSource.isTitleStrokeWidthEnabled = true
        segmentedSource.isSelectedAnimable = true
        let indicator = JXSegmentedIndicatorImageView()
        indicator.image = UIImage(named: "indecrot")
        indicator.indicatorWidth = 24
        indicator.indicatorHeight = 18
        segmentedView.indicators = [indicator]
        //4、配置JXSegmentedView的属性
        view.addSubview(segmentedView)
        //5、初始化JXSegmentedListContainerView
        listView = JXSegmentedListContainerView(dataSource: vc as! JXSegmentedListContainerViewDataSource)
        view.addSubview(listView)
        //6、将listContainerView.scrollView和segmentedView.contentScrollView进行关联
        segmentedView.listContainer = listView
        segmentedView.frame = frame
        listView.frame = CGRect(x: 0, y: frame.height + frame.origin.y, width: frame.width, height: view.bounds.size.height - frame.height - frame.origin.y)
    }
    
    func updateSegment(titles: [String]) {
        segmentedSource.titles = titles
        segmentedView.reloadData()
    }
    
    func configIndicator(indicator: JXSegmentedIndicatorLineView? = nil) {
        if (indicator != nil) {
            segmentedView.indicators = [indicator!]
        } else {
            let ind = JXSegmentedIndicatorLineView()
            ind.indicatorColor = UIColor(hex: "#3251C2") ?? .blue
            ind.indicatorWidthIncrement = -20
            segmentedView.indicators = [ind]
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentedView.defaultSelectedIndex = currrentIndex;
    }
    
    
}
   
    

extension LoanPlusOrderVC: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedSource.dataSource.count
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = LoanPlusOrderChildVC(title: "")
        if index == 0 {
            vc.type = "4"
        } else if index == 1 {
            vc.type = "7"
        } else if index == 2 {
            vc.type = "6"
        } else if index == 3 {
            vc.type = "5"
        }
        return vc
    }
    
    
    
    
    
}
