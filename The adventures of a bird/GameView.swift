//
//  GameView.swift
//  The adventures of a bird
//
//  Created by Роман on 24.01.2024.
//

import SwiftUI

struct GameView: View {
    private let birdPosition = CGPoint(x: 100, y: 300)
    private let topPipeHeight = CGFloat.random(in: 100...500)
    private let pipeWight:CGFloat = 100
    private let pipeSpacing:CGFloat = 100
    private let ofsetPipe:CGFloat = 0
    private let score = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack{
                    Image(.flappyBirdBackground)
                        .resizable()
                        .ignoresSafeArea()
                        .padding(.bottom, -50)
                        .padding(.trailing, -50)
                    
                    BirdView(birdSize: 100)
                        .position(birdPosition)
                    
                    PipeView(topPipeHeight: topPipeHeight, pipeWight: pipeWight, pipeSpacing: pipeSpacing)
                        .offset(x: geometry.size.width + ofsetPipe)
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Text(score.formatted())
                            .font(.title)
                            .foregroundStyle(.white)
                    }
                })
            }
        }
    }
}

#Preview {
    GameView()
}
