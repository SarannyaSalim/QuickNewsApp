//
//  CellConfugurator.swift
//  QuickNews
//
//  Created by Sarannya on 19/05/19.
//  Copyright © 2019 Sarannya. All rights reserved.
// Reference:https://medium.com/chili-labs/configuring-multiple-cells-with-generics-in-swift-dcd5e209ba16

import UIKit
import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    func configureCell(with data : DataType)
}

protocol CellConfigurator {
    associatedtype DataType
    
    static var reuseId: String { get }
    func configure(cell: UIView, data : DataType)
}

class NewsCollectionCellConfigurator<CellType : ConfigurableCell, DataType> : CellConfigurator where CellType.DataType == DataType, CellType: UICollectionViewCell{
    
    static var reuseId: String { return String(describing: CellType.self) }
    
    func configure(cell: UIView, data: DataType) {
        (cell as! CellType).configureCell(with: data)
    }
    
    
}

