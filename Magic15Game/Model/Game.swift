//
//  Game.swift
//  Magic15Game
//
//  Created by Igor Malyarov on 08.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Game {
    let rows: Int
    let columns: Int
    
    private(set) var tiles: Matrix<Tile>
    private var target1: Matrix<Tile>
    private var target2: Matrix<Tile>
    private(set) var steps: Int
    
    init() {
        self.init(rows: 4, columns: 4)
    }
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        
        self.tiles = Matrix(rows: rows, columns: rows) { row, col in
            let number = row * columns + col
            return Tile(face: number == 0 ? "dot" : String(number))
        }
        self.tiles.shuffle()
        
        //  MARK: Target
        
        self.target1 = Matrix(rows: rows, columns: rows) { row, col in
            let number = row * columns + col
            return Tile(face: number + 1 == 16 ? "dot" : String(number + 1))
        }
        
        //  MARK: - нужен еще вариант, где 14 и 15 переставлены местами!!!!
        //  MARK: ИСПРАВИТЬ!!!!
        self.target2 = Matrix(rows: rows, columns: rows) { row, col in
            let number = row * columns + col
            return Tile(face: number + 1 == 16 ? "dot" : String(number + 1))
        }

        self.steps = 0
    }
    
    var gameOver: Bool {
        let tileFaces    =   tiles.matrix.flatMap{ $0 }.map { $0.face }
        let target1Faces = target1.matrix.flatMap{ $0 }.map { $0.face }
        let target2Faces = target2.matrix.flatMap{ $0 }.map { $0.face }
        
        return tileFaces == target1Faces || tileFaces == target2Faces
    }
    
    //  MARK: - Move
    
    mutating func moveTile(row: Int, column: Int) {
        guard tile(row: row, column: column).face != "dot" else {
            print("can't move dot")
            return
        }

        //  selected tile is not dot, check adjacent
        
//        print("moving tile with face \(tile(row: row, column: column).face)")

        let possibleIndices: [(row: Int, column: Int)] = [
            (row, column - 1),
            (row, column + 1),
            (row - 1, column),
            (row + 1, column)
        ]
            .filter { tiles.indexIsValid(row: $0.row, column: $0.column) }
        
        for index in possibleIndices {
            if tiles[index.row, index.column].face == "dot" {
                tiles.swapAt(aIndex: index, bIndex: (row: row, column: column))
                steps += 1
                break
            }
        }
    }
    
    //  MARK: - Model Access
    
    func tile(row: Int, column: Int) -> Tile {
        tiles[row, column]
    }
}

struct Tile: Identifiable, Equatable {
    var face: String
    //    var position: Int || (row: Int, col: Int)
    
    var id = UUID()
}
