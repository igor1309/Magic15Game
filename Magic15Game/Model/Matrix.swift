//
//  Matrix.swift
//  Magic15Game
//
//  Created by Igor Malyarov on 08.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Matrix<T: Equatable>: Equatable {
    let rows: Int
    let columns: Int
    
    private var grid: [T]
    
    init(rows: Int, columns: Int, defaultValue: @escaping (Int, Int) -> T) {
        self.rows = rows
        self.columns = columns
        
        var grid = [T]()
        for row in 0..<rows {
            for column in 0..<columns {
                grid.append(defaultValue(row, column))
            }
        }
        self.grid = grid
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> T {
        get {
            grid[(row * columns) + column]
        }
        set {
            grid[(row * columns) + column] = newValue
        }
    }
    
    var matrix: [[T]] {
        var matrix = [[T]]()
        for row in 0..<rows {
            var matrixRow = [T]()
            for column in 0..<columns {
                matrixRow.append(grid[(row * columns) + column])
            }
            matrix.append(matrixRow)
        }
        return matrix
    }
    
    mutating func swapAt(
        aIndex: (row: Int, column: Int),
        bIndex: (row: Int, column: Int)
    ) {
        grid.swapAt((aIndex.row * columns) + aIndex.column, (bIndex.row * columns) + bIndex.column)
    }
    
    mutating func shuffle() {
        self.grid.shuffle()
    }
}
