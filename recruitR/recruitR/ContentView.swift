//
//  ContentView.swift
//  recruitR
//
//  Created by Andy Huang on 4/24/22.
//

import SwiftUI

struct ContentView: View {
    // Variables for displaying candidate sheet.
    @State var showingCandidateInfo = false
    @State var cardData = Card.data
    @State var currentCardIndex = 0
    
    // Variables for candidate review page
    @State var likedCandidates: [Card] = []
    @State var dislikedCandidates: [Card] = []
    
    var body: some View {
        NavigationView {
            VStack {
                // Top Stack
                HStack {
                    NavigationLink(destination: ProfileView()) {
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("niceLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: ReviewView(dislikedCandidates: dislikedCandidates, likedCandidates: likedCandidates)) {
                        Image("list")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    VStack(alignment: .center) {
                        Image("upload")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        
                        Text("No candidates? Click the logo to import more!").font(.body).foregroundColor(Color.gray)
                    }
                    
                    // Insert Cards into ForEach
                    ForEach(Card.data.reversed()) { card in
                        cardView(card: card, showingCandidateInfo: $showingCandidateInfo, dislikedCandidates: $dislikedCandidates, likedCandidates: $likedCandidates, currentCardIndex: $currentCardIndex)
                            .padding(8)
                    }
                }
                .zIndex(1.0)
                
                // Bottom Stack
                HStack(spacing: 0) {
                    
                    Button(action: {}) {
                        Image("remove")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                    
                    Button(action: {}) {
                        Image("heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 60)
                    }
                    .padding(.horizontal, 50)
                    
                    Button(action: {}) {
                        Image("check")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 45)
                    }
                }
                .padding(.horizontal)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showingCandidateInfo) {
                candidateInfoView(isPresented: $showingCandidateInfo, currentCardIndex: currentCardIndex)
            }
        }
    }
}

// ReviewView
struct ReviewView: View {
    var dislikedCandidates: [Card]
    var likedCandidates: [Card]
    @State var selectedTab: String = "liked"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            LikedCandidatesView(likedCandidates: likedCandidates)
                .id(1)
                .tabItem {
                    Label("Liked", systemImage: "heart")
                }
                .tag("liked")
            
            DislikedCandidatesView(dislikedCandidates: dislikedCandidates)
                .id(2)
                .tabItem {
                    Label("Disliked", systemImage: "x.circle")
                }
                .tag("disliked")
        }
    }
}

// LikedCandidatesView
struct LikedCandidatesView: View {
    var likedCandidates: [Card]
    var body: some View {
            VStack {
                List {
                    Section(header: Text("Liked")) {
                    ForEach(likedCandidates) { card in
                        NavigationLink(destination: candidateReviewInfoView(card: card)) {
                            HStack {
                                Image(card.imageName)
                                    .resizable()
                                    .clipShape(Circle())
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                
                                Text(card.name).font(.body)
                            }
                        }
                    }
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
    }
}

// DislikedCandidatesView
struct DislikedCandidatesView: View {
    var dislikedCandidates: [Card]
    var body: some View {
            VStack {
                List {
                    Section(header: Text("Disliked")) {
                    ForEach(dislikedCandidates) { card in
                        NavigationLink(destination: candidateReviewInfoView(card: card)) {
                            HStack {
                                Image(card.imageName)
                                    .resizable()
                                    .clipShape(Circle())
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                
                                Text(card.name).font(.body)
                            }
                        }
                    }
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
    }
}

// CandidateInfoView
struct candidateInfoView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    var currentCardIndex: Int
    var card: Card {
        Card.data[currentCardIndex]
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    
                    Button("Done") {
                        dismiss()
                    }
                    .padding(.horizontal)
                }
                
                VStack {
                    Image(card.imageName)
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                    
                    Text(card.name).font(.largeTitle).bold()
                    Text(card.bio)
                    
                    Divider()
                    
                    Group {
                        HStack {
                            Text("Bio")
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        HStack {
                            Text(card.longBio)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        HStack {
                            Text("Why are you interested?")
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        HStack {
                            Text(card.interest)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        Group {
                            HStack {
                                Text("Year")
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            HStack {
                                Text(card.year)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            HStack {
                                Text("Major")
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            HStack {
                                Text(card.major)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            HStack {
                                Text("Resume/CV")
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            HStack {
                                Text("resume.pdf")
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

// CandidateReviewInfoView
struct candidateReviewInfoView: View {
    @State var card: Card
    
    var body: some View {
        ScrollView {
            VStack {
                
                VStack {
                    Image(card.imageName)
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                    
                    Text(card.name).font(.largeTitle).bold()
                    Text(card.bio)
                    
                    Divider()
                    
                    Group {
                        HStack {
                            Text("Bio")
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        HStack {
                            Text(card.longBio)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        HStack {
                            Text("Why are you interested?")
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        HStack {
                            Text(card.interest)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        Group {
                            HStack {
                                Text("Year")
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            HStack {
                                Text(card.year)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            HStack {
                                Text("Major")
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            HStack {
                                Text(card.major)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            HStack {
                                Text("Resume/CV")
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            HStack {
                                Text("resume.pdf")
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    
                    
                }
                Spacer()
            }
            .padding()
        }
    }
}

// Card View
struct cardView: View {
    @State var card: Card
    @Binding var showingCandidateInfo: Bool
    @Binding var dislikedCandidates: [Card]
    @Binding var likedCandidates: [Card]
    @Binding var currentCardIndex: Int
    
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
                        // Add candidate to liked array.
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                            likedCandidates.append(card)
                            currentCardIndex += 1
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0
                        // Take action when card is swiped far left
                        // Add candidate to dislike array.
                        case let x where x < -100:
                            card.x = -500; card.degree = -12
                            dislikedCandidates.append(card)
                            currentCardIndex += 1
                        default: card.x = 0; card.y = 0
                        }
                    }
                }
        )
        .onTapGesture {
            showingCandidateInfo.toggle()
        }
        
    }
}

// Profile View
struct ProfileView: View {
    
    var firstName: String = "Rahul"
    var lastName: String = "Roy"
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Image("rahul")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                    Text(firstName)
                        .font(.title)
                        .bold()
                    
                    Text("President of Berkeley Consulting")
                        .font(.body)
                }
                
                
                Divider()
                
                VStack {
                    Text("About")
                        .font(.title)
                        .bold()
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 10)
                    
                    Text("Full Name")
                        .font(.body)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 10)
                    
                    Text(firstName  + " " + lastName)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 10)
                    
                    Divider()
                    
                    Text("Email")
                        .font(.body)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 10)
                    
                    Text("rahul1988@gmail.com")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 10)
                    
                    Divider()
                    
                    HStack {
                        VStack {
                            Text("Applications Received")
                                .font(.body)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading, .bottom], 10)
                            
                            Text("36")
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading, .bottom], 10)
                        }
                        
                        VStack {
                            Text("Candidates")
                                .font(.body)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading, .bottom], 10)
                            
                            Text("12")
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading, .bottom], 10)
                        }
                    }
                    
                    Divider()
                    
                    Text("Social URL")
                        .font(.body)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 10)
                }
            }
        }
        .navigationBarTitle("Profile")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
