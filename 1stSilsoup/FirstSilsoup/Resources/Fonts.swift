//
//  Fonts.swift
//  FirstSilsoup
//
//  Created by 이주현 on 3/23/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        case blackFont
        case extraLight
        case thinFont
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Ligh"
            case .blackFont:
                return "Pretendard-Black"
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .thinFont:
                return "Pretendard-Thin"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var PretendardBold30: Font {
        return .pretend(type: .bold, size: 30)
    }
    static var PretendardLigth16: Font {
        return .pretend(type: .light, size: 16)
    }
    static var PretendardBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    static var PretendardSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
}
