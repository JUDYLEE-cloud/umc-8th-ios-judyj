//
//  VisionView.swift
//  FourthSilsoup
//
//  Created by 이주현 on 4/13/25.
//

import Foundation
import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
    var recognizedText: String { get set }
}
