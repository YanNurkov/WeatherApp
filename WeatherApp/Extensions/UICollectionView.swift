//
//  UICollectionView.swift
//  WeatherApp
//
//  Created by Ян Нурков on 26.04.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    convenience init(withFlowLayout: Bool) {
        if withFlowLayout {
            self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        } else {
            self.init(frame: .zero)
        }
    }
}
