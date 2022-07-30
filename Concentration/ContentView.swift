//
//  ContentView.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/26/22.
//

import SwiftUI

// View
struct ContentView: View {

    @ObservedObject var viewModel: EmojiConcentrationGame // the instance of this particular game
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))] ){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}
            
struct CardView: View {
    let card: ConcentrationGame<String>.Card
        
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3) // stroke INSIDE object vs. half and half with just stroke
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}
            






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiConcentrationGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
            .previewDevice("iPod touch (7th generation)")
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            .previewDevice("iPod touch (7th generation)")
    }
}

