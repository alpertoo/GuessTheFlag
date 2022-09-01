//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alper Koçer on 29.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var showReset = false
    @State private var scoreTitle = ""
    @State private var userScore: Int = 0
    @State private var gameRound: Int = 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    
    var body: some View {
        ZStack{
            // LinearGradient(gradient: Gradient(colors: [.blue, //.black]), startPoint: .top, endPoint: .bottom)
                //.ignoresSafeArea()
            
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){number in
                        Button{
                           flagTapped(number)
                        } label: {
                            Image( countries[number] )
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Round: \(gameRound)")
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("End of the game", isPresented: $showReset){
            Button("New Game", action: reset)
        } message: {
            Text("Your final score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            userScore += 1
            scoreTitle = "Correct"
        } else {
            if userScore != 0{
                userScore -= 1
            }else{
                userScore = 0
            }
            
            scoreTitle = "Wrong!\nThat's the flag of\n \(countries[correctAnswer])"
        }
        
        if gameRound < 8{
            showingScore = true
        }else{
            showReset = true
        }
    }
    
    func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            gameRound += 1
    }
    
    func reset() {
        gameRound = 0
        userScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
