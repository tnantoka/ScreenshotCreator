import UIKit

let bundle = Bundle.main

struct Device {
    static func load(_ name: String) -> UIImage {
        let path = bundle.path(forResource: name, ofType: "png", inDirectory: "Devices")
        return UIImage(contentsOfFile: path!)!
    }
    
    static let phone = Device.load("Apple iPhone 7 Plus Silver")
    static let pad = Device.load("Apple iPad Pro Silver")
}

struct Size {
    static let phone = CGSize(width: 1242.0, height: 2208.0)
    static let pad = CGSize(width: 2048.0, height: 2732.0)
}

struct Screenshot {
    let screen: UIImage
    let filename: String
    
    var size: CGSize {
        return Size.phone
    }
    var rect: CGRect {
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    let titleRectScale: CGFloat = 0.1
    var titleRect: CGRect {
        var rect = self.rect
        rect.size.height *= titleRectScale
        return rect
    }
    
    init?(path: String) {
        guard let screen = UIImage(contentsOfFile: path) else { return nil }

        self.screen = screen
        filename = ((path as NSString).lastPathComponent as NSString).deletingPathExtension
    }
    
    static var all: [Screenshot] = {
        return bundle.paths(forResourcesOfType: "png", inDirectory: "Screenshots").flatMap { path in
            Screenshot(path: path)
        }
    }()
    
    func framed(config: ScreenshotConfig) -> UIImage {
        let title = config.title(filename)

        let opaque = true
        let scale: CGFloat = 1.0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(config.backgroundColor.cgColor)
        context.fill(rect)
        
        drawDevice(in: context)
        drawTitle(title, in: context, attributed: textAttributes(config))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func drawDevice(in context: CGContext) {
        let scale: CGFloat = 0.7
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        
        let deviceSize = Device.phone.size.applying(transform)
        let deviceOrigin = CGPoint(
            x: rect.midX - deviceSize.width / 2.0,
            y: rect.midY - deviceSize.height / 2.0
        )
        Device.phone.draw(in: CGRect(origin: deviceOrigin, size: deviceSize).offsetBy(dx: 0.0, dy: titleRect.height))
        
        let screenSize = screen.size.applying(transform)
        let screenOrigin = CGPoint(
            x: rect.midX - screenSize.width / 2.0,
            y: rect.midY - screenSize.height / 2.0
        )
        screen.draw(in: CGRect(origin: screenOrigin, size: screenSize).offsetBy(dx: 0.0, dy: titleRect.height))
    }
    
    func textAttributes(_ config: ScreenshotConfig) -> [String : Any] {
        let fontSize = size.height * config.fontSizeScaleY
        
        let defaultStyle = NSParagraphStyle.default
        let style = defaultStyle.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = .center
        
        let attributes: [String : Any] = [
            NSFontAttributeName: UIFont(name: config.fontName, size: fontSize)!,
            NSForegroundColorAttributeName: config.textColor,
            NSParagraphStyleAttributeName: style,
            ]
        
        return attributes
    }
    
    func drawTitle(_ title: String, in context: CGContext, attributed attributes: [String : Any]) {
        let frame = title.boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin, .usesFontLeading,],
            attributes: attributes,
            context: nil
        )
        
        title.draw(
            in:titleRect.offsetBy(
                dx: 0.0,
                dy: titleRect.midY
            ),
            withAttributes: attributes
        )
    }
}

public struct ScreenshotConfig {
    public var backgroundColor = UIColor.gray
    public var textColor = UIColor.white
    
    public var fontSizeScaleY: CGFloat = 0.04
    public var fontName = ".SFUIDisplay-Light"
    
    public var titles: [String: String] = [:]
    
    public func title(_ filename: String) -> String {
        return titles[filename] ?? "Untitled"
    }
    
    public init() {        
    }
}

public struct ScreenshotCreator {
    public init() {
        
    }

    public func preview(config: ScreenshotConfig) -> [UIImage] {
        return Screenshot.all.map { $0.framed(config: config) }
    }
}