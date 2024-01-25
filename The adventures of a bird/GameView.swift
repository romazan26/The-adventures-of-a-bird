//
//  GameView.swift
//  The adventures of a bird
//
//  Created by Роман on 24.01.2024.
//

import SwiftUI

struct GameView: View {
    @State private var birdPosition = CGPoint(x: 100, y: 300)
    @State private var topPipeHeght = CGFloat.random(in: 100...500)
    @State private var offsetPipe:CGFloat = 0
    @State private var score = 0
    @State private var highScore: Int = 0
    @State private var lastUpdateTimer = Date()
    @State private var birdVelocity = CGVector(dx: 0, dy: 0)
    @State private var gameState = GameState.ready
    @State private var passedPipe = false
    
    private let pipeWidth:CGFloat = 100
    private let pipeSpacing:CGFloat = 200
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    private let birdSize = 80.0
    private let birdRadius = 13.0
    
    
    enum GameState {
        case ready, active, stopped
    }
    
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
                    
                    PipeView(topPipeHeight: topPipeHeght, pipeWight: pipeWidth, pipeSpacing: pipeSpacing)
                        .offset(x: geometry.size.width + offsetPipe)
                    
                    if gameState == .ready {
                        Button {
                            playAction()
                        } label: {
                            Image(systemName: "play.fill")
                        }
                        .font(.system(size: 100))
                        .foregroundStyle(.white)

                    }
                    if gameState == .stopped {
                        ResultView(score: score, hightScore: highScore) {
                            resetAction()
                        }
                    }

                }
                .onTapGesture {
                    birdVelocity = CGVector(dx: 0, dy: -350)
                }
                .onReceive(timer, perform: { currentTime in
                    guard gameState == .active else{return}
                    let deltaTime = currentTime.timeIntervalSince(lastUpdateTimer)
                    
                    applyGravity(deltaTime: deltaTime)
                    updateBirdPosition(deltaTime: deltaTime)
                    checkBounds(geomerty: geometry)
                    updatePipePosition(delataTime: deltaTime)
                    resetPipePosition(geometry: geometry)
                    updateScore(geometry: geometry)
                    if checkCoolisions(geometry: geometry){
                        gameState = .stopped
                    }
                    lastUpdateTimer = currentTime
                })
                
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
    private func applyGravity(deltaTime: TimeInterval){
        birdVelocity.dy += CGFloat(1000 * deltaTime)
    }
    private func updateBirdPosition(deltaTime: TimeInterval){
        birdPosition.y += birdVelocity.dy * deltaTime
    }
    private func checkBounds(geomerty: GeometryProxy){
        if birdPosition.y > geomerty.size.height - 50 {
            birdPosition.y = geomerty.size.height - 50
            birdVelocity.dy = 0
        }
        if birdPosition.y <= 0{
            birdPosition.y = 0
        }
    }
    private func updatePipePosition(delataTime: TimeInterval){
        offsetPipe -= 300 * delataTime
    }
    private func resetPipePosition(geometry: GeometryProxy){
        if offsetPipe <= -geometry.size.width - pipeWidth{
            offsetPipe = 0
            topPipeHeght = CGFloat.random(in: 100...500)
        }
    }
    private func playAction(){
        gameState = .active
        lastUpdateTimer = Date()
    }
    private func checkCoolisions(geometry: GeometryProxy) -> Bool {
        let birdFrame = CGRect(x: birdPosition.x - birdRadius / 2,
                               y: birdPosition.y - birdRadius / 2,
                               width: birdRadius,
                               height: birdRadius)

        let topPipeFrame = CGRect(x: geometry.size.width + offsetPipe,
                                  y: 0,
                                  width: pipeWidth,
                                  height: topPipeHeght)

        let bottomPipeFrame = CGRect(x: geometry.size.width + offsetPipe,
                                     y: topPipeHeght + pipeSpacing,
                                     width: pipeWidth,
                                     height: topPipeHeght)

        return birdFrame.intersects(topPipeFrame) || birdFrame.intersects(bottomPipeFrame)
    }
    private func updateScore(geometry: GeometryProxy) {
        if offsetPipe + pipeWidth + geometry.size.width < birdPosition.x && !passedPipe {
            score += 1
            passedPipe = true

            if score > highScore {
                highScore = score
            }

        } else if offsetPipe + geometry.size.width > birdPosition.x {
            passedPipe = false
        }
    }
    private func resetAction() {
        gameState = .ready
        birdPosition = CGPoint(x: 100, y: 300)
        offsetPipe = 0
        topPipeHeght = CGFloat.random(in: 100...500)
        score = 0
    }
}

#Preview {
    GameView()
}
