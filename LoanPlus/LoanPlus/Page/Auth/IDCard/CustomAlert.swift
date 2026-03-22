//
//  CustomAlert.swift
//  LoanPlus
//
//  Created by hao on 2024/11/29.
//


class CustomAlert {
    static var alertBgGray = UIButton(type: .custom)
    static var alertShow = false
    
    static func show(contentView:UIView) {
        if (alertShow) {
            return
        }
        if Thread.isMainThread {
            show(contentView: contentView)
        }else{
            DispatchQueue.main.async {
                show(contentView: contentView)
            }
        }
        func show(contentView:UIView) {
            alertShow = true
            let window = UIApplication.shared.windows.first!
            alertBgGray = UIButton(frame: window.bounds)
            alertBgGray.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            alertBgGray.addTarget(self, action:  #selector(hideAlert), for: .touchUpInside)
            window.addSubview(alertBgGray)
            alertBgGray.addSubview(contentView)
        }
    }
    
    @objc static func hideAlert() {
        alertShow = false
        UIView.animate(withDuration: 0.2) {
            alertBgGray.alpha = 0
        } completion: { finished in
            alertBgGray.removeFromSuperview()
        }
    }
}
