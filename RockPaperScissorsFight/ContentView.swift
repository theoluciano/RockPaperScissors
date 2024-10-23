//
//  ContentView.swift
//  RockPaperScissorsFight
//
//  Created by Theo Luciano on 10/22/24.
//

import SwiftUI

struct ChoiceButton: View {
    var buttonContent: String
    
    var body: some View {
        Text(buttonContent)
            .font(.system(size: 48))
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(radius: 0, x: 0, y: 4)
    }
}

struct ContentView: View {
    @State private var appChoices = ["🪨", "📄", "✂️"].shuffled()
    @State var winOrLose = Bool.random()
    
    @State private var userScore = 0
    @State private var appCurrentChoice = Int.random(in: 0...2)
    
    @State private var gameIsComplete = false
    @State private var round = 0

    
    var body: some View {
        ZStack {
            Rectangle().fill(.blue.gradient.opacity(0.8)).ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .font(.system(size: 32))
                    .foregroundStyle(.secondary)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack {
                    Spacer()
                    VStack {
                        Text("Win or Lose")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                        
                        Text("\(shouldWin())")
                            .font(.system(size: 48, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                    VStack {
                        Text("App Choice")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                        
                        Text(appChoices[appCurrentChoice])
                            .font(.system(size: 48))
                            .foregroundStyle(.primary)
                    }
                    Spacer()
                }
                .frame(width: 340, height: (160))
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 16))
                
                Spacer()
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        attemptAnswer("🪨")
                    } label: {
                        ChoiceButton(buttonContent: "🪨")
                    }
                    
                    Spacer()
                    
                    Button {
                        attemptAnswer("📄")
                    } label: {
                        ChoiceButton(buttonContent: "📄")
                    }
                    
                    Spacer()
                    
                    Button {
                        attemptAnswer("✂️")
                    } label: {
                        ChoiceButton(buttonContent: "✂️")
                    }
                    
                    Spacer()
                }
                .alert("Game Over", isPresented: $gameIsComplete) {
                    Button("Restart", action: restartGame)
                } message: {
                    Text("Your score is \(userScore) out of a possible 10")
                }
            }
        }
    }
    
    func correctAnswer(_ userAnswer: String) -> Bool {
        if shouldWin() == "Win" {
            if userAnswer == "🪨" && appChoices[appCurrentChoice] == "✂️"{
                return true
            } else if userAnswer == "📄" && appChoices[appCurrentChoice] == "🪨"{
                return true
            } else if userAnswer == "✂️" && appChoices[appCurrentChoice] == "📄"{
                return true
            } else {
                return false
            }
        } else {
            if userAnswer == "✂️" && appChoices[appCurrentChoice] == "🪨"{
                return true
            } else if userAnswer == "🪨" && appChoices[appCurrentChoice] == "📄"{
                return true
            } else if userAnswer == "📄" && appChoices[appCurrentChoice] == "✂️"{
                return true
            } else {
                return false
            }
        }
        
    }
    
    func attemptAnswer(_ answer: String) {
        if correctAnswer(answer) {
            userScore += 1
            
        } else {
            userScore -= 1
        }
        
        if round == 10 {
            gameIsComplete = true
            
        } else {
            round += 1
            winOrLose.toggle()
            appCurrentChoice = Int.random(in: 0...2)
        }
    }
    
    func shouldWin() -> String {
        if winOrLose {
            return "Win"
        } else {
            return "Lose"
        }
    }

    func restartGame() {
        gameIsComplete = false
        userScore = 0
        winOrLose = Bool.random()
        appCurrentChoice = Int.random(in: 0...2)
        round = 0
    }
}

#Preview {
    ContentView()
}
