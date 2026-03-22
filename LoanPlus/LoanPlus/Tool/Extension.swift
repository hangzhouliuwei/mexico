//
//  Extension.swift
//  LoanPlus
//
//  Created by hao on 2024/11/25.
//

import Foundation
import UIKit

protocol Addable { }

extension Int: Addable { }
extension Double: Addable { }

func + <T: Addable, U: Addable>(lhs: T, rhs: U) -> Double {
    let leftValue = (lhs as? Double) ?? Double(lhs as! Int)
    let rightValue = (rhs as? Double) ?? Double(rhs as! Int)
    return leftValue + rightValue
}

func - <T: Addable, U: Addable>(lhs: T, rhs: U) -> Double {
    let leftValue = (lhs as? Double) ?? Double(lhs as! Int)
    let rightValue = (rhs as? Double) ?? Double(rhs as! Int)
    return leftValue - rightValue
}

func * <T: Addable, U: Addable>(lhs: T, rhs: U) -> Double {
    let leftValue = (lhs as? Double) ?? Double(lhs as! Int)
    let rightValue = (rhs as? Double) ?? Double(rhs as! Int)
    return leftValue * rightValue
}

func / <T: Addable, U: Addable>(lhs: T, rhs: U) -> Double {
    let leftValue = (lhs as? Double) ?? Double(lhs as! Int)
    let rightValue = (rhs as? Double) ?? Double(rhs as! Int)
    return leftValue / rightValue
}

func + (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) + rhs
}

func + (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs + CGFloat(rhs)
}

func - (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) - rhs
}

func - (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs - CGFloat(rhs)
}

func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}

func * (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs * CGFloat(rhs)
}

func / (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) / rhs
}

func / (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
}


extension Double {
    var stringValue: String {
        return String(self)
    }
    var intValue:Int {
        return lround(self)
    }
    var w:Double {
        return self*(ScreenWidth/375.0)
    }
}

extension Int {
    var stringValue: String {
        return String(self)
    }
    var doubleValue:Double {
        return Double(self)
    }
    var w:Double {
        return Double(self)*(ScreenWidth/375.0)
    }
}

extension UIFont {
    
    public class func font(_ size:CGFloat) -> UIFont {
        if let font = UIFont(name: "D-DIN-PRO-Regular", size: size) {
            return font
        }else {
            return .systemFont(ofSize: size, weight: .regular)
        }
    }
    public class func fontMedium(_ size:CGFloat) -> UIFont {
        if let font = UIFont(name: "D-DIN-PRO-SemiBold", size: size) {
            return font
        }else {
            return .systemFont(ofSize: size, weight: .medium)
        }
    }
    public class func fontBold(_ size:CGFloat) -> UIFont {
        if let font = UIFont(name: "D-DIN-PRO-Bold", size: size) {
            return font
        }else {
            return .systemFont(ofSize: size, weight: .bold)
        }
    }
    
    public class func font_pfr(_ size:CGFloat) -> UIFont {
        if let font = UIFont(name: "PingFangSC-Regular", size: size) {
            return font
        }else {
            return .systemFont(ofSize: size, weight: .regular)
        }
    }
    
    public class func font_pfm(_ size:CGFloat) -> UIFont {
        if let font = UIFont(name: "PingFangSC-Medium", size: size) {
            return font
        }else {
            return .systemFont(ofSize: size, weight: .medium)
        }
    }
    
    public class func font_pfS(_ size:CGFloat) -> UIFont {
        if let font = UIFont(name: "PingFangSC-Semibold", size: size) {
            return font
        }else {
            return .systemFont(ofSize: size, weight: .semibold)
        }
    }
}

extension Array {
    subscript(nullable idx: Int) ->Element? {
        if (startIndex ..< endIndex).contains(idx) {
            return self[idx]
        }
        return nil
    }
}

extension String {
    var intValue:Int {
        return Int(self) ?? 0
    }
    
    var doubleValue:Double {
        return Double(self) ?? 0
    }
    
    func subString(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy: start)
        let en = self.index(st, offsetBy: len)
        return String(self[st ..< en])
    }
    
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    var isPhoneNumber: Bool {
        let phoneRegex = "^1[3-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
        
    var isAllNumber: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    var isaAllChinese:Bool {
        let match:String = "SELF matches (^[\u{4e00}-\u{9fa5}]+$)"
        let predicate:NSPredicate = NSPredicate(format: match)
        let result = predicate.evaluate(with: self)
        return result
    }
    
    var chineseString:String {
        let regex = "[^\u{4e00}-\u{9fa5}]"
        return self.replacingOccurrences(of: regex, with: "", options: .regularExpression,range: nil)
    }
    
    var isAllLetters: Bool {
        !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }

    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    var decodeUrl: String {
        return self.removingPercentEncoding ?? self
    }
    
    var toUrl: URL? {
        URL(string: self)
    }
    
    var toDictionary: [String: Any]? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
    
    var toArray: [Any]? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
    }
    
    var attributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
    
    public func height(width containerWidth: CGFloat, font: UIFont) -> CGFloat {
        size(width: containerWidth, font: font).height
    }

    public func size(width: CGFloat, font: UIFont) -> CGSize {
        let size = (self as NSString).boundingRect(
                with: CGSize(width: width, height: .greatestFiniteMagnitude),
                options: [.usesFontLeading, .usesLineFragmentOrigin],
                attributes: [.font: font],
                context: nil).size
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
    static func nowTimeString() -> String {
        let time = Date().timeIntervalSince1970 * 1000
        let timeStr = String(format: "%.0f", time)
        return timeStr
    }
}

extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        
        self.init(cgImage: cgImage)
    }
    
    
    func resetToSize(size:CGSize) -> UIImage{
        if (self.size.width > size.width) {
            UIGraphicsBeginImageContext(size)
            self.draw(in: CGRectMake(0, 0, size.width, size.height))
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resultImage!
        }
        return self
    }
    
    func resetToKBit(toKB:Int) -> UIImage {
        let limit = toKB * 1024
        var scale = 0.9
        let maxScale = 0.1
        var data = self.jpegData(compressionQuality: scale)
        while data!.count > limit && scale > maxScale {
            scale -= 0.1
            data = self.jpegData(compressionQuality: scale)
        }
        return UIImage(data: data!)!
    }
    
    static func imageWithColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    static func getGradientImage(size:CGSize) -> UIImage{
        if size == CGSizeZero{
            return UIImage()
        }
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else{return UIImage()}
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientRef = CGGradient(colorsSpace: colorSpace, colors: [UIColor.init(r: 0, g: 181, b: 186).cgColor,UIColor.init(r: 196, g: 253, b: 126).cgColor] as CFArray, locations: nil)!
        let startPoint = CGPoint(x: size.width/3, y: size.height/3*2)
        let endPoint = CGPoint(x: size.width/3*2, y: size.height/3)
        context.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(arrayLiteral: .drawsBeforeStartLocation,.drawsAfterEndLocation))
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradientImage ?? UIImage()
    }
}

extension Dictionary{
    var toString:String{
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8) ?? ""
        return str
    }
    
    static func + (lhs: Dictionary, rhs: Dictionary) -> Dictionary {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
}

extension UIButton {
    
    static func create(title: String? = nil, titleColor: UIColor? = .clear, font: UIFont? = .font(15)) -> UIButton{
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        return button
    }
    
    public var title:String {
        get {
            return self.title(for: .normal) ?? ""
        }
        set(value) {
            self.setTitle(value, for: .normal)
        }
    }
    
    func setGradientText(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 1), endPoint: CGPoint = CGPoint(x: 1, y: 0)) {
        self.layoutIfNeeded()
        guard let titleLabel = self.titleLabel, let titleText = titleLabel.text else { return }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = titleLabel.bounds
        
        let renderer = UIGraphicsImageRenderer(size: titleLabel.bounds.size)
        let gradientImage = renderer.image { context in
            gradientLayer.render(in: context.cgContext)
        }
        
        let gradientColor = UIColor(patternImage: gradientImage)
        let attributedString = NSAttributedString(
            string: titleText,
            attributes: [.foregroundColor: gradientColor]
        )
        self.setAttributedTitle(attributedString, for: .normal)
    }

}

extension UILabel {
    
    static func create(text: String?, textColor: UIColor?, font: UIFont?) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = textColor ?? .textBlack
        label.font = font ?? .font(15)
        return label
    }
    
    func setLineSpace(_ lineSpacing: CGFloat, text:String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    func setTextWithColor(_ text: String, color:UIColor) {
        if text.isEmpty {
            return
        }
        let fullText = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: text) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: color, range: nsRange)
            self.attributedText = attributedString
        }
    }
    
    func setGradientText(startPoint: CGPoint = CGPoint(x: 0.5, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1)) {
        guard let text = self.text else { return }
        self.layoutIfNeeded()
        let colors = [
            UIColor.white.withAlphaComponent(0.5),
            UIColor.white.withAlphaComponent(0)
        ]
        
        let fontSize:CGFloat = 60
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Bold", size: fontSize).withSymbolicTraits([.traitBold, .traitItalic]) ?? UIFontDescriptor()
        let font = UIFont(descriptor: fontDescriptor, size: fontSize)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = CGRect(origin: .zero, size: intrinsicContentSize)
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let gradientColor = UIColor(patternImage: gradientImage ?? UIImage())
        let attributedText = NSAttributedString(string: text, attributes: [
            .foregroundColor: gradientColor,
            .font: font
        ])
        
        self.attributedText = attributedText
    }
}


extension UIView {
    
    public var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    public var right:CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set(newRight) {
            self.x = newRight - self.width
        }
    }
    
    public var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var origin:CGPoint {
        get {
            return self.frame.origin
        }
        set(newOrigin) {
            var rect = self.frame
            rect.origin = newOrigin
            self.frame = rect
        }
    }
    
    public var size:CGSize {
        get {
            return self.frame.size
        }
        set(newSize) {
            var rect = self.frame
            rect.size = newSize
            self.frame = rect
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    
    public var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue != 0
        }
    }
    
    func addTopRound(radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func addBottomRound(radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func addRound() {
        self.cornerRadius = self.height/2
    }
    
    func addBottomRightRound(radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: [.bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func addBlur(style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    public var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addBorder() {
        self.borderColor = .lineGray
        self.borderWidth = 1
    }
    
    func addBorder(color:UIColor, width:CGFloat) {
        self.borderColor = color
        self.borderWidth = width
    }
    
    func addShadow(color:UIColor ,opacity:CGFloat,radius:CGFloat,offset:CGSize) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    public func removeAllSubviews() {
        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    public func addGradient(colors: [CGColor], start:CGPoint, end:CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func screenshotImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

    func addTap(method: @escaping () -> Void) {
        let tapGesture = ClosureTapGestureRecognizer(action: method)
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
}

class ClosureTapGestureRecognizer: UITapGestureRecognizer {
    private var action: (() -> Void)?

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(handleTap))
    }

    @objc private func handleTap() {
        action?()
    }
}

extension UIColor {
    public convenience init(hex: Int, alpha: Double = 1) {
        self.init(
            red: CGFloat((hex >> 16) & 0xff)/255.0,
            green: CGFloat((hex >> 8) & 0xff)/255.0,
            blue: CGFloat(hex & 0xff)/255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    
    convenience init?(hex: String, alpha: CGFloat = 1) {

        var hex = hex

        if hex.hasPrefix("#") {

            let index = hex.index(after: hex.startIndex)
            hex = String(hex[index...])
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0

        if scanner.scanHexInt64(&hexValue) {

            switch hex.count {
            case 3:
                red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
                blue = CGFloat(hexValue & 0x00F) / 15.0
            case 6:
                red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexValue & 0x0000FF) / 255.0
            default:
                return nil
            }
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    public convenience init(r: Int, g: Int, b: Int, a: Double = 1) {
        self.init(
            red: CGFloat(r)/255.0,
            green: CGFloat(g)/255.0,
            blue: CGFloat(b)/255.0,
            alpha: CGFloat(a)
        )
    }
    
    func alpha(value:Double) -> UIColor {
        return self.withAlphaComponent(value)
    }
    
    static var main: UIColor {
        UIColor(r: 124, g: 105, b: 255)
    }
    
    static var lightMain: UIColor {
        UIColor(r: 235, g: 242, b: 255)
    }
    
    static var bg: UIColor {
        UIColor(r: 255, g: 255, b: 255)
    }
    
    static var textBlack: UIColor {
        UIColor(r: 11, g: 26, b: 60)
    }
    
    static var textGray: UIColor {
        UIColor(r: 103, g: 114, b: 138)
    }
    
    static var lineGray: UIColor {
        UIColor(r: 238, g: 240, b: 244)
    }
    
    static var bgViewGray: UIColor {
        UIColor(r: 246, g: 248, b: 250)
    }
    
    static var cellTitle: UIColor {
        UIColor(r: 103, g: 114, b: 138)
    }
    
    static var grayHalfColor: UIColor {
        .black.withAlphaComponent(0.5)
    }
}

extension UITableViewCell {
    static func registerCell<T: UITableViewCell>(from tableView: UITableView) -> T {
        let identifier = String(describing: T.self)
        return tableView.dequeueReusableCell(withIdentifier: identifier) as? T ?? T(style: .default, reuseIdentifier: identifier)
    }
}

public extension Notification.Name {
    static let updateUserInfo = NSNotification.Name(rawValue: "HomePageRefresh")
    static let updateTransLine = NSNotification.Name(rawValue: "XXXXXX")
}
