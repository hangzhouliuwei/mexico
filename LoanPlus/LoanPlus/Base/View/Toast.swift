//
//  Toast.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//


class Toast {
    static func show(content:String) {
        show(content: content, time: 1.5)
    }
    static func show(content:String, time:Double) {
        
        if Thread.isMainThread {
            show(content: content, time: time)
        }else{
            DispatchQueue.main.async {
                show(content: content, time: time)
            }
        }
        func show(content:String, time:Double) {
            if (content.count == 0) {
                return
            }
            let window = UIApplication.shared.windows.first!
            let bgView = UIImageView(frame: window.bounds)
            bgView.isUserInteractionEnabled = true
            
            let viewWith = ScreenWidth/2
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: viewWith - 20, height: 0))
            label.text = content
            label.textColor = .white
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.sizeToFit()

            let grayView = UIView(frame: CGRect(x: 0, y: 0, width: label.width + 20, height: label.height + 20))
            grayView.center = bgView.center;
            grayView.layer.cornerRadius = 10;
            grayView.backgroundColor = .black.alpha(value: 0.8)
            grayView.addSubview(label)
            bgView.addSubview(grayView)
            window.addSubview(bgView)
            UIView.animate(withDuration: 0.2) {
                grayView.alpha = 1
            } completion: { finished in
                Timer.scheduledTimer(timeInterval: time - 0.5, target: self, selector: #selector(hide), userInfo: bgView, repeats: false)
            }
        }
    }
    
    static func show(content:String, time:Double, imageName:String) {
        if (content.count == 0) {
            return
        }
        
        if Thread.isMainThread {
            show(content: content, time: time)
        }else{
            DispatchQueue.main.async {
                show(content: content, time: time)
            }
        }
        func show(content:String, time:Double) {
            let window = UIApplication.shared.windows.first!
            let bgView = UIImageView(frame: window.bounds)
            bgView.isUserInteractionEnabled = true
            window.addSubview(bgView)

            let viewWith = 116
            let grayView = UIView(frame: CGRect(x: 0, y: 0, width: viewWith, height: viewWith))
            grayView.center = bgView.center;
            grayView.layer.cornerRadius = 10;
            grayView.backgroundColor = .black.alpha(value: 0.8)
            bgView.addSubview(grayView)
            
            let icon = UIImageView(frame: CGRect(x: 0, y: 32, width: 24, height: 24))
            icon.centerX = viewWith/2
            icon.image = UIImage(named: imageName)
            grayView.addSubview(icon)

            let label = UILabel(frame: CGRect(x: 10, y: icon.bottom, width: viewWith - 20, height: 40))
            label.text = content
            label.textColor = .white
            label.numberOfLines = 2
            label.font = UIFont.font(14)
            label.textAlignment = .center
            label.backgroundColor = .clear
            grayView.addSubview(label)
            
            UIView.animate(withDuration: 0.2) {
                grayView.alpha = 1
            } completion: { finished in
                Timer.scheduledTimer(timeInterval: time - 0.5, target: self, selector: #selector(hide), userInfo: bgView, repeats: false)
            }
        }
    }
    
    @objc static func hide(timer:Timer) {
        let toastView:UIView = timer.userInfo as! UIView
        UIView.animate(withDuration: 0.2) {
            toastView.alpha = 0
        } completion: { finished in
            toastView.removeFromSuperview()
        }
    }
}

class Loading: UIView {
    
    static let shared = Loading()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(loadingIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadingIndicator.frame = CGRect(x: (self.frame.width - 30) / 2, y: 30, width: 30, height: 30)
        loadingIndicator.centerX = self.width/2
        loadingIndicator.centerY = self.height/2
    }
    
    // 显示loading
    private func show() {
        let window = UIApplication.shared.windows.first!
        overlayView.frame = window.bounds
        window.addSubview(overlayView)
        
        self.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        self.center = window.center
        overlayView.addSubview(self)
    }
    
    // 隐藏loading
    private func hide() {
        removeFromSuperview()
        overlayView.removeFromSuperview()
    }
    
    static func show() {
        Loading.shared.show()
    }
    
    static func hide() {
        Loading.shared.hide()
    }
}
