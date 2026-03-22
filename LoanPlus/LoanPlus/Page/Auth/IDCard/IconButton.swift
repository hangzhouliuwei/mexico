//
//  IconButtonType.swift
//  LoanPlus
//
//  Created by hao on 2024/12/2.
//


enum IconButtonType {
    case type1//左图右文（居中）
    case type2//左图右文（居左）
    case type3//左文右图（居中）
    case type4//左文右图（居右）
    case type5//上图下文
    case type6//上图下文(图文间距10)
    case type7//左文右图（居左）
    case type8//左图右文（居右）
    case type9//左文右图（两边对齐）
    case type10//上文下图
}

class IconButton: UIButton {

    private var type: IconButtonType = .type1
    var titleStr: String?

    init(frame: CGRect, title: String, color: UIColor, font: UIFont?, icon: String) {
        super.init(frame: frame)
        self.titleLabel?.font = font
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.setImage(UIImage(named: icon), for: .normal)
        setType(type: .type1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setType(type: IconButtonType) {
        self.type = type
        switch type {
        case .type1: break
            // 默认样式

        case .type2:
            self.contentHorizontalAlignment = .left
            self.contentVerticalAlignment = .center

        case .type3:
            self.contentHorizontalAlignment = .center
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -self.imageView!.bounds.size.width, bottom: 0, right: self.imageView!.bounds.size.width + 4)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.titleLabel!.bounds.size.width, bottom: 0, right: -self.titleLabel!.bounds.size.width)

        case .type4:
            self.contentHorizontalAlignment = .right
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -self.imageView!.bounds.size.width, bottom: 0, right: self.imageView!.bounds.size.width + 4)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.titleLabel!.bounds.size.width, bottom: 0, right: -self.titleLabel!.bounds.size.width)

        case .type5:
            self.titleEdgeInsets = UIEdgeInsets(top: self.frame.size.height / 2, left: (self.frame.size.width - self.titleLabel!.intrinsicContentSize.width) / 2 - self.imageView!.frame.size.width, bottom: 0, right: (self.frame.size.width - self.titleLabel!.intrinsicContentSize.width) / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (self.frame.size.width - self.imageView!.frame.size.width) / 2, bottom: self.titleLabel!.intrinsicContentSize.height, right: (self.frame.size.width - self.imageView!.frame.size.width) / 2)

        case .type6:
            self.titleEdgeInsets = UIEdgeInsets(top: self.frame.size.height / 2, left: (self.frame.size.width - self.titleLabel!.intrinsicContentSize.width) / 2 - self.imageView!.frame.size.width, bottom: -5, right: (self.frame.size.width - self.titleLabel!.intrinsicContentSize.width) / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: -5, left: (self.frame.size.width - self.imageView!.frame.size.width) / 2, bottom: self.titleLabel!.intrinsicContentSize.height, right: (self.frame.size.width - self.imageView!.frame.size.width) / 2)

        case .type7:
            self.contentHorizontalAlignment = .left
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -self.imageView!.bounds.size.width, bottom: 0, right: self.imageView!.bounds.size.width + 4)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.titleLabel!.bounds.size.width, bottom: 0, right: -self.titleLabel!.bounds.size.width)

        case .type8:
            self.contentHorizontalAlignment = .right
            self.contentVerticalAlignment = .center

        case .type9:
            self.contentHorizontalAlignment = .left
            self.titleEdgeInsets = UIEdgeInsets.zero
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.bounds.width - self.titleLabel!.bounds.size.width - self.imageView!.bounds.size.width - 8, bottom: 0, right: 0)

        case .type10:
            self.titleEdgeInsets = UIEdgeInsets(top: -(self.imageView!.frame.size.height + 5), left: -self.imageView!.frame.size.width, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: self.titleLabel!.intrinsicContentSize.height + 5, left: 0, bottom: 0, right: -self.titleLabel!.intrinsicContentSize.width)
        }
    }

    func setTitle(_ title: String) {
        self.setTitle(title, for: .normal)
        setType(type: self.type)
        self.titleStr = title
    }
}

class MxButton:UIButton {
    func config(frame:CGRect, title:String, font:UIFont = .fontMedium(18)) {
        self.titleLabel?.font = font
        self.frame = frame
        self.backgroundColor = .black
        self.cornerRadius = self.height/2
        self.setTitle(title, for: .normal)
        self.setGradientText(colors: [UIColor.init(r: 0, g: 181, b: 186),UIColor.init(r: 196, g: 253, b: 126)])
    }
}
