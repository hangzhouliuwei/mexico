//
//  DateAlert.swift
//  LoanPlus
//
//  Created by hao on 2024/12/3.
//


class DateAlert: UIView {
    var selectBlock:StringBlock?
    var bgHide = true
    var isAnimated = false
    let bgView = UIButton(type: .custom)
    let contentView = UIView()
    var dateStr = ""
    init(date: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        dateStr = date
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadUI() {
        bgView.backgroundColor = .black
        bgView.alpha = 0.0
        bgView.frame = self.frame
        self.addSubview(bgView)

        contentView.backgroundColor = .init(hex: 0xEBF2FF)
        contentView.frame = CGRect(x: 0, y: self.height - 354 - SafeBottomHeight, width:ScreenWidth, height: 354 + SafeBottomHeight)
        contentView.addTopRound(radius: 24)
        self.addSubview(contentView)

        let cancel = UILabel(frame: CGRect(x: 20, y: 21, width: 92, height: 33))
        cancel.textColor = .init(hex: 0x2747BF)
        cancel.text = "Cancelar"
        cancel.font = .systemFont(ofSize: 15)
        contentView.addSubview(cancel)
        cancel.addTap {[weak self] in
            self?.hide()
        }
        
        let confirm = MxButton(type: .custom)
        confirm.config(frame: CGRect(x: ScreenWidth - 92 - 20, y: 21, width: 92, height: 33), title: "Confirmar")
        contentView.addSubview(confirm)
        confirm.addTap { [weak self] in
            self?.selectAction()
        }
        
        let bgWhite = UIView(frame: CGRect(x: 15, y: 78, width: ScreenWidth - 30, height: 251))
        bgWhite.backgroundColor = .white
        bgWhite.cornerRadius = 16
        contentView.addSubview(bgWhite)
        
        let datePicker = UIDatePicker(frame: CGRect(x: 15, y: 78, width: ScreenWidth - 30, height: 251))
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = Locale(identifier: "en-AU")
        datePicker.datePickerMode = .date

        let minTime = time(with: "01-01-1960", formatter: "dd-MM-yyyy")
        let maxTime = time(with: "31-12-2040", formatter: "dd-MM-yyyy")
        let minDate = Date(timeIntervalSince1970: minTime)
        let maxDate = Date(timeIntervalSince1970: maxTime)
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.frame = CGRect(x: 15, y: 78, width: ScreenWidth - 30, height: 251)
        datePicker.addTarget(self, action: #selector(dateChange(_:)), for: .valueChanged)

        if dateStr.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateStr = dateFormatter.string(from: Date())
        }

        let times = time(with: dateStr, formatter: "dd-MM-yyyy")
        let selectedDate = Date(timeIntervalSince1970: TimeInterval(times))
        datePicker.setDate(selectedDate, animated: true)
        contentView.addSubview(datePicker)
    }
    
    @objc func dateChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.string(from: datePicker.date)
        dateStr = date
    }
    
    func selectAction() {
        self.selectBlock?(dateStr)
        hide()
    }
    
    func time(with dateStr: String, formatter: String) -> TimeInterval {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        guard let date = dateFormatter.date(from: dateStr) else {
            return 0
        }
        return date.timeIntervalSince1970
    }

    func show() {
        if isAnimated {
            return
        }
        isAnimated = true
        self.alpha = 1;
        let window = UIApplication.shared.windows.first!
        window.addSubview(self)
        
        let rect = contentView.frame;
        contentView.frame = CGRectMake(rect.origin.x, ScreenHeight, rect.size.width, rect.size.height);
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame = rect
            self.bgView.alpha = 0.3
        }, completion: {_ in
            self.isAnimated = false
        })
    }

    func hide() {
        if isAnimated {
            return
        }
        if bgHide {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }, completion: {_ in
                self.removeFromSuperview()
            })
        }
    }
}
