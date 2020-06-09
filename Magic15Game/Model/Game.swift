//
//  Game.swift
//  Magic15Game
//
//  Created by Igor Malyarov on 08.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Game<TileFace: Equatable> {
    let rows: Int
    let columns: Int
    
    private(set) var tiles: Matrix<Tile<TileFace>>
    private let target1IDs: [Int]
    private let target2IDs: [Int]
    private(set) var steps: Int
    private(set) var gameOver: Bool = false
    
    
    init(rows: Int,
         columns: Int,
         tileFactory: @escaping (Int, Int) -> Tile<TileFace>
    ) {
        self.rows = rows
        self.columns = columns
        
        self.tiles = Matrix(rows: rows, columns: rows) { row, col in
            tileFactory(row, col)
        }
        self.tiles.shuffle()
        
        self.steps = 0
        
        
        //  MARK: Target
        
        var target1 = Array(1...(rows * columns - 1))
        target1.append(0)
        self.target1IDs = target1
        
        var target2 = Array(1...(rows * columns - 3))
        target2.append(rows * columns - 1)
        target2.append(rows * columns - 2)
        target2.append(0)
        self.target2IDs = target2
    }
    
    //  MARK: - Move
    
    mutating func moveTile(row: Int, column: Int) {
        func checkGameOver() {
            print(target1IDs)
            print(target2IDs)
            let tileIDs = tiles.matrix.flatMap{ $0 }.map { $0.id }
            gameOver = tileIDs == target1IDs || tileIDs == target2IDs
        }
        
        
        guard tile(row: row, column: column).id != 0 else {
            print("can't move tile with ID 0")
            return
        }
        
        //  selected tile ID is not 0, check adjacent to find tile with ID 0 and move
        
        let possibleIndices: [(row: Int, column: Int)] = [
            (row, column - 1),
            (row, column + 1),
            (row - 1, column),
            (row + 1, column)
            ]
            .filter { tiles.indexIsValid(row: $0.row, column: $0.column) }
        
        for index in possibleIndices {
            if tiles[index.row, index.column].id == 0 {
                tiles.swapAt(aIndex: index, bIndex: (row: row, column: column))
                steps += 1
                checkGameOver()
                break
            }
        }
    }
    
    //  MARK: - Model Access
    
    func tile(row: Int, column: Int) -> Tile<TileFace> {
        tiles[row, column]
    }
}

struct Tile<TileFace: Equatable>: Identifiable, Equatable {
    var id: Int
    var face: TileFace
}
