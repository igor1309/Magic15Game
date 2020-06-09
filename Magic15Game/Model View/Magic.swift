//
//  Magic.swift
//  Magic15Game
//
//  Created by Igor Malyarov on 08.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

final class Magic: ObservableObject {
    @Published private var game = Game()
    
    //  MARK: - Model Access
    
    func tile(row: Int, column: Int) -> Tile {
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
        game = Game()
    }
}
