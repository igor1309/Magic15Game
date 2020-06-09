//
//  Magic.swift
//  Magic15Game
//
//  Created by Igor Malyarov on 08.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

final class Magic15: ObservableObject {
    
    @Published private var game: Game<String> = Magic15.createGame()
    
    static func createGame() -> Game<String> {
        let rows = 4
        let columns = 4
        
        return Game<String>(rows: rows, columns: columns) { row, column in
            let ix = row * columns + column
            let face = ix == 0 ? "dot": String(ix)
            
            return Tile(id: ix, face: face)
        }
    }
    
    //  MARK: - Model Access
    
    func tile(row: Int, column: Int) -> Tile<String> {
        game.tile(row: row, column: column)
    }
    
    func moveTile(row: Int, column: Int) {
        game.moveTile(row: row, column: column)
    }
    
    var steps: Int {
        game.steps
    }
    
    var gameOver: Bool {
        game.gameOver
    }
    
    var rows: Int {
        game.rows
    }
    var columns: Int {
        game.columns
    }
    
    func reset() {
        game = Magic15.createGame()
    }
}
