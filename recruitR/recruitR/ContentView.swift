//
//  ContentView.swift
//  recruitR
//
//  Created by Andy Huang on 4/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            VStack {
                // Top Stack
                HStack {
                    Button(action: {}) {
                        Image("user")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("note")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    // Insert Cards into ForEach
                    ForEach(Card.data.reversed()) { card in
                        cardView(card: card)
                            .padding(8)
                    }
                }
                .zIndex(1.0)
                
                // Bottom Stack
                HStack(spacing: 0) {
                    
                    Button(action: {}) {
                        Image("dislike")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                    
                    Button(action: {}) {
                        Image("love")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                    .padding(.horizontal, 50)
                    
                    Button(action: {}) {
                        Image("like")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                }
                .padding(.horizontal)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

// CandidateInfoView
struct candidateInfoView: View {
    @State var card: Card
    var body: some View {
        Text("Hello World1")
    }
}

// Card View
struct cardView: View {
    @State var card: Card
    
    // Card Gradient Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(card.imageName)
                .resizable()
            
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Text(card.name).font(.largeTitle).fontWeight(.bold)
                        Text(String(card.age)).font(.title)
                    }
                    Text(card.bio)
                }
            }
            .padding()
            .foregroundColor(.white)
            
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 - 1))
                
                Spacer()
                
                Image("nope")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .opacity(Double(card.x/10 * -1 - 1))
            }
        }
        .cornerRadius(8)
        
        // Card Swiping Logic
        // 1. Zstack follows the coordinate of the card model
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        // 2. Gesture recogniser updates the coordinate values of the card model
        .gesture (
            DragGesture()
                .onChanged { value in
                    // user is dragging the card view
                    withAnimation(.default) {
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1: -1)
                    }
                    
                }
            
                .onEnded { value in
                    // do something when user stops dragging
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0.0)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        // Take action when card is swiped far right
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0
                        // Take action when card is swiped far left
                        case let x where x < -100:
                            card.x = -500; card.degree = -12
                        default: card.x = 0; card.y = 0
                        }
                    }
                }
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
