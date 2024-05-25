import UIKit

extension UIColor {
    // Creates color from a hex string
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }

    // Ниже приведены примеры цветов, настоящие цвета надо взять из фигмы

    // Primary Colors
    static let primary = UIColor(red: 0 / 255, green: 122 / 255, blue: 255 / 255, alpha: 1.0)

    // Secondary Colors
    static let secondary = UIColor(red: 255 / 255, green: 193 / 255, blue: 7 / 255, alpha: 1.0)

    // Background Colors
    static let background = UIColor.white

    // Text Colors
    static let textPrimary = UIColor.black
    static let textSecondary = UIColor.gray
    static let textOnPrimary = UIColor.white
    static let textOnSecondary = UIColor.black

    private static let yaBlackLight = UIColor(hexString: "1A1B22")
    private static let yaBlackDark = UIColor.white
    private static let yaLightGrayLight = UIColor(hexString: "#F7F7F8")
    private static let yaLightGrayDark = UIColor(hexString: "#2C2C2E")

    static let segmentActive = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaBlackDark
        : .yaBlackLight
    }

    static let segmentInactive = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaLightGrayDark
        : .yaLightGrayLight
    }

    static let closeButton = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaBlackDark
        : .yaBlackLight
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: - Day Mode Colors
    static let blackDay = UIColor(hex: 0x1A1B22)
    static let whiteDay = UIColor(hex: 0xFFFFFF)
    static let lightGrayDay = UIColor(hex: 0xF7F7F8)
    
    // MARK: - Night Mode Colors
    static let whiteNight = UIColor(hex: 0x1A1B22)
    static let blackNight = UIColor(hex: 0xFFFFFF)
    static let lightGrayNight = UIColor(hex: 0x2C2C2E)
    
    // MARK: - Universal Colors
    static let greyUniversal = UIColor(hex: 0x625C5C)
    static let redUniversal = UIColor(hex: 0xF56B6C)
    static let backgroundUniversal = UIColor(hex: 0x1A1B2280, alpha: 0.5)
    static let greenUniversal = UIColor(hex: 0x1C9F00)
    static let blueUniversal = UIColor(hex: 0x0A84FF)
    static let blackUniversal = UIColor(hex: 0x1A1B22)
    static let whiteUniversal = UIColor(hex: 0xFFFFFF)
    static let yellowUniversal = UIColor(hex: 0xFEEF0D)
    
    // MARK: - Additional Colors
    static let closeButtonColor = UIColor(hex: 0x8E8E93)
    static let userPhotoEditorBackgroundColor = UIColor(hex: 0x1A1B22, alpha: 0.6)
}
