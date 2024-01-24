//
//  BirdView.swift
//  The adventures of a bird
//
//  Created by Роман on 24.01.2024.
//

import SwiftUI

struct BirdView: View {
    
    let birdSize: CGFloat
    
    var body: some View {
        Image(.flappyBird)
            .resizable()
            .scaledToFit()
            .frame(width: birdSize, height: birdSize)
    }
}

#Preview {
    BirdView(birdSize: 150)
}
