import Foundation
import SwiftUI

extension Font {
    static func bold(_ size: CGFloat) -> Font {
        return StarbucksCloneTuistFontFamily.Pretendard.bold.swiftUIFont(size: size)
    }
    
    static var mainTextBold24: Font {
        return .bold(24)
    }
}

//extension Font {
//    enum Pretend {
//        case extraBold
//        case bold
//        case semibold
//        case medium
//        case regular
//        case light
//        case blackFont
//        case extraLight
//        case thinFont
//        
//        var value: String {
//            switch self {
//            case .extraBold:
//                return "Pretendard-ExtraBold"
//            case .bold:
//                return "Pretendard-Bold"
//            case .semibold:
//                return "Pretendard-SemiBold"
//            case .medium:
//                return "Pretendard-Medium"
//            case .regular:
//                return "Pretendard-Regular"
//            case .light:
//                return "Pretendard-Ligh"
//            case .blackFont:
//                return "Pretendard-Black"
//            case .extraLight:
//                return "Pretendard-ExtraLight"
//            case .thinFont:
//                return "Pretendard-Thin"
//            }
//        }
//    }
//    
//    static func pretend(type: Pretend, size: CGFloat) -> Font {
//        return .custom(type.value, size: size)
//    }
//    
//    static var mainTextBold20: Font {
//        return .pretend(type: .bold, size:20)
//    }
//    static var mainTextBold24: Font {
//        return .pretend(type: .bold, size: 24)
//    }
//    static var mainTextSemibold24: Font {
//        return .pretend(type: .semibold, size: 24)
//    }
//    static var mainTextSemiBold18: Font {
//        return .pretend(type: .semibold, size: 18)
//    }
//    static var mainTextSemibold16: Font {
//        return .pretend(type: .semibold, size: 16)
//    }
//    static var mainTextSemibold14: Font {
//        return .pretend(type: .semibold, size: 14)
//    }
//    static var mainTextMedium16: Font {
//        return .pretend(type: .medium, size: 16)
//    }
//    static var mainTextRegular18: Font {
//        return .pretend(type: .regular, size: 18)
//    }
//    static var mainTextRegular13: Font {
//        return .pretend(type: .regular, size: 13)
//    }
//    static var mainTextRegular12: Font {
//        return .pretend(type: .regular, size: 12)
//    }
//    static var mainTextRegular09: Font {
//        return .pretend(type: .regular, size: 9)
//    }
//    static var mainTextLigth14: Font {
//        return .pretend(type: .light, size: 14)
//    }
//    static var mainTextExtraBold24: Font {
//        return .pretend(type: .extraBold, size: 24)
//    }
//    static var mainTextSemiBold38: Font {
//        return .pretend(type: .semibold, size: 38)
//    }
//    static var mainTextSemiBold13: Font {
//        return .pretend(type: .semibold, size: 13)
//    }
//    static var makeMedium18: Font {
//        return .pretend(type: .medium, size: 18)
//    }
//    
//}
