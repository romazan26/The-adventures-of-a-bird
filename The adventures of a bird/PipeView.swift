//
//  PipeView.swift
//  The adventures of a bird
//
//  Created by Роман on 24.01.2024.
//

import SwiftUI

struct PipeView: View {
    
    let topPipeHeight: CGFloat
    let pipeWight: CGFloat
    let pipeSpacing: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let avaliabeSpacing = geometry.size.height - pipeSpacing
            let bottomPipeHeight = avaliabeSpacing - topPipeHeight
            
            VStack {
                Image(.flappeBirdPipe)
                    .resizable()
                    .scaleEffect(y: -1)
                    .frame(width: pipeWight, height: topPipeHeight)
                Spacer()
                    .frame(height: pipeSpacing)
                
                Image(.flappeBirdPipe)
                    .resizable()
                    .frame(width: pipeWight, height: bottomPipeHeight)
                
            }
        }
        
    }
}

#Preview {
    PipeView(topPipeHeight: 300, pipeWight: 100, pipeSpacing: 100)
}
