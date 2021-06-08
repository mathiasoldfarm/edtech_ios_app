//
//  Quiz.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 31/05/2021.
//

import SwiftUI

struct Quiz: View {
    var quizLevelData: QuizLevelsData;
    var botWrapper: BotWrapper?;
    @State private var chosen : Int = -1;
    @State private var current : Int = 0;
    @State private var answers: [String: String] = [:];
    
    var body: some View {
            VStack {
                let question : QuestionData = quizLevelData.questions[current];
                let submitted: Bool = chosen != -1;
                
                Text(question.question)
                    .padding(.bottom, 15)
                ForEach(question.possibleAnswers.indices) { i in
                    Button(action: {
                        answers[String(question.id)] = String(question.possibleAnswers[i].id);
                        chosen = i
                    }) {
                        Text(question.possibleAnswers[i].answer)
                            .frame(maxWidth: .infinity)
                            .padding(4)
                            .background(Color.blue.opacity(submitted ? 0.8 : 1))
                            .foregroundColor(.white)
                    }
                    .disabled(submitted)
                }
                if ( submitted ) {
                    let correct : Bool = question.possibleAnswers[chosen].id == question.correct.id;
                    
                    Text("\(question.possibleAnswers[chosen].explanation)")
                        .foregroundColor(correct ? Color.green : Color.red)
                    
                    if ( current == quizLevelData.questions.count - 1 ) {
                        GeometryReader { geometry in
                            Button(action: {
                                if ( botWrapper != nil ) {
                                    let nMessages: Int = botWrapper!.messageData.count
                                    let userIndex : Int = botWrapper!.userMessages.count
                                    let botIndex : Int = botWrapper!.botMessages.count
                                    
                                    let nextUserMessage: UserMessage = UserMessage(text: question.possibleAnswers[chosen].answer)
                                    
                                    botWrapper!.userMessages.append(nextUserMessage)
                                    
                                    botWrapper!.messageData[nMessages - 1].messages.append(
                                        SingleMessage(type: SingleMessageType.user, index: userIndex)
                                    )
                                    
                                    let currentBotMessage : BotMessage = botWrapper!.botMessages[botWrapper!.botMessages.count - 1];
                                    
                                    let body : Data = try! JSONSerialization.data(withJSONObject: answers);
                                    
                                    botWrapper!.loader.loadNext(contextId: currentBotMessage.contextId, initialHistoryId: currentBotMessage.historyId, type: 1, question: String(data: body, encoding: .utf8)!, botWrapper: botWrapper!)
                                    
                                    botWrapper!.messageData.append(
                                        MessageSection(
                                            id: nMessages,
                                            messages: [SingleMessage(type: SingleMessageType.bot, index: botIndex)]
                                        )
                                    )
                                }
                            }) {
                                Text("Done")
                                    .frame(maxWidth: .infinity)
                                    .padding(4)
                                    .background(Color.blue)
                                    .padding(.top, 20)
                                    .foregroundColor(.white)
                            }
                        }
                    } else {
                        Button(action: {
                            if ( botWrapper != nil ) {
                                let userIndex : Int = botWrapper!.userMessages.count
                                let nMessages: Int = botWrapper!.messageData.count
                                let nextUserMessage: UserMessage = UserMessage(text: question.possibleAnswers[chosen].answer)
                                
                                botWrapper!.userMessages.append(nextUserMessage)
                                
                                botWrapper!.messageData[nMessages - 1].messages.append(
                                    SingleMessage(type: SingleMessageType.user, index: userIndex)
                                )
                            }
                            
                            current += 1;
                            chosen = -1;
                            
                        }) {
                            Text("Next question")
                                .frame(maxWidth: .infinity)
                                .padding(4)
                                .background(Color.blue)
                                .padding(.top, 20)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(20)
        }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        let messages: [BotMessage] = Loader.load("messagestest.json")
        
        Quiz(quizLevelData: messages[3].section.quiz!.levels[0], botWrapper: nil)
    }
}
