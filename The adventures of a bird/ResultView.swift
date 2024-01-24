//
//  ResultView.swift
//  The adventures of a bird
//
//  Created by Роман on 24.01.2024.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    let hightScore: Int
    let resetAction: () -> Void
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .padding()
            Text("Score: \(score.formatted())")
                .font(.title)
            Text("Best: \(hightScore.formatted())")
                .padding()
            Button("Reset") {
                resetAction()
            }.buttonStyle(.borderedProminent)
                .padding()
        }.background(.white.opacity(0.8))
            .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    ResultView(score: 10, hightScore: 20, resetAction: {})
}
