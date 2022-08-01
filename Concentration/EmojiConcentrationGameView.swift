//
//  EmojiConcentrationGameView.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/26/22.
//

import SwiftUI

// View
struct EmojiConcentrationGameView: View {

    @ObservedObject var game: EmojiConcentrationGame // the instance of this particular game
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 30))] ){
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}
            
struct CardView: View {
    let card: EmojiConcentrationGame.Card
        
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth) // stroke INSIDE object vs. half and half with just stroke
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 2
        static let fontScale: CGFloat = 0.7
    }
}
            






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiConcentrationGame()
        EmojiConcentrationGameView(game: game)
            .preferredColorScheme(.dark)
            .previewDevice("iPod touch (7th generation)")
        EmojiConcentrationGameView(game: game)
            .preferredColorScheme(.light)
            .previewDevice("iPod touch (7th generation)")
    }
}

