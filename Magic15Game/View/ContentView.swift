//
//  ContentView.swift
//  Magic15Game
//
//  Created by Igor Malyarov on 08.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    var systemName: String
    var action: () -> Void
    
    init(_ systemName: String, action: @escaping () -> Void) {
        self.systemName = systemName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .padding()
        }
    }
}


struct ContentView: View {
    @ObservedObject var magic = Magic()
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ButtonView("rectangle.on.rectangle.angled") {
                        self.magic.reset()
                    }
                    Spacer()
                }
                
                if !magic.gameOver {
                    Text("Steps: \(magic.steps)")
                        .foregroundColor(.orange)
                        .font(.headline)
                }
            }
            
            Spacer()
            
            if !magic.gameOver {
                ForEach(0..<magic.rows) { row in
                    self.rowView(row)
                }
            } else {
                VStack {
                    Text("Game Over")
                        .font(.title)
                    
                    Text("Steps: \(magic.steps)")
                        .font(.headline)
                }
                .foregroundColor(.orange)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func rowView(_ row: Int) -> some View {
        return HStack {
            ForEach(0..<self.magic.columns) { column in
                self.tile(row: row, column: column)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.magic.moveTile(row: row, column: column)
                        }
                }
            }
        }
    }
    
    private func tile(row: Int, column: Int) -> some View {
        let face = magic.tile(row: row, column: column).face
        
        return Image(systemName: "\(face).square")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(face == "dot" ? 0.1 : 1)
            .foregroundColor(Color(UIColor.systemTeal))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewColorSchemes(.dark)
    }
}
