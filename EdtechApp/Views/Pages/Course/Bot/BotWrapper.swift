//
//  Bot.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 01/06/2021.
//

import SwiftUI

struct BotWrapper: View {
    @State var loader : MessageLoader
    @State var botMessages: [BotMessage] = []
    @State var userMessages: [UserMessage] = []
    @State var messageData: [MessageSection] = []
    
    @State var submissionFailed : Bool = false;
    @State var submissionSucceded : Bool = false;
    @State var submissionMessage : String = "";
    
    var body: some View {
        VStack {
            if ( submissionFailed ) {
                Text(submissionMessage)
                    .foregroundColor(.red)
            } else {
                GeometryReader { geometry in
                    VStack {
                        if ( messageData.count > 0 ) {
                            ScrollView(.vertical) {
                                ScrollViewReader { scrollView in
                                    ForEach(messageData) { messageSection in
                                        VStack {
                                            ForEach( messageSection.messages, id: \.self ) { singleMessage in
                                                if ( singleMessage.type == SingleMessageType.bot ) {
                                                    if ( botMessages.count - 1 >= (singleMessage.index) ) {
                                                        HStack() {
                                                            let botMessage : BotMessage = botMessages[singleMessage.index]
                                                            
                                                            if (( botMessage.section.description ) != nil) {
                                                                TextMessage(text:                         botMessage.section.description!.levels[0].description)
                                                            } else {
                                                                Quiz(quizLevelData: botMessage.section.quiz!.levels[0], botWrapper: self)
                                                            }
                                                            Spacer()
                                                        }
                                                        .padding(.leading, 20)
                                                        .padding(.trailing, 75)
                                                    }
                                                    
                                                } else {
                                                    if ( userMessages.count - 1 >= (singleMessage.index) ) {
                                                        HStack() {
                                                            Spacer()
                                                            let userMessage : UserMessage = userMessages[singleMessage.index]
                                                            TextMessage(text: userMessage.text)
                                                        }
                                                        .padding(.leading, 75)
                                                        .padding(.trailing, 20)
                                                    }
                                                }
                                            }
                                        }
                                        .frame(height: geometry.size.height*0.9)
                                        .id(messageSection.id)
                                    }
                                    .onChange(of: messageData.count) { _ in
                                        withAnimation(.easeInOut(duration: 120)) {
                                            scrollView.scrollTo(messageData.last?.id)
                                        }
                                    }
                                }
                            }
                            .frame(height: geometry.size.height*0.9)
                        }
                        
                        HStack {
                            if ( messageData.count < 1 || ( !submissionFailed && !submissionSucceded ) ) {
                                
                                Spinner()
                                    .onAppear() {
                                        if (botMessages.count < 1) {
                                            loader.loadNext(contextId: 0, initialHistoryId: 0, type: 0, question: "BEGINNING", botWrapper: self)
                                            messageData.append(MessageSection(
                                                id: 0,
                                                messages: [SingleMessage(type: SingleMessageType.bot, index: 0)]
                                            ))
                                        }
                                    }
                            } else {
                                let currentBotMessage : BotMessage = botMessages[botMessages.count - 1]
                                if ((  currentBotMessage.nextPossibleAnswers) != nil) {
                                    VStack {
                                        WrappingStack(content: currentBotMessage.nextPossibleAnswers!.map{text in
                                            Button(action: {
                                                let botIndex : Int = botMessages.count
                                                let userIndex : Int = userMessages.count
                                                let nMessages: Int = messageData.count
                                                
                                                loader.loadNext(contextId: currentBotMessage.contextId, initialHistoryId: currentBotMessage.historyId, type: 0, question: text, botWrapper: self)
                                                
                                                
                                                let nextUserMessage: UserMessage = UserMessage(text: text)
                                                
                                                userMessages.append(nextUserMessage)
                                                
                                                messageData[nMessages - 1].messages.append(
                                                    SingleMessage(type: SingleMessageType.user, index: userIndex)
                                                )
                                                
                                                messageData.append(
                                                    MessageSection(
                                                        id: nMessages,
                                                        messages: [SingleMessage(type: SingleMessageType.bot, index: botIndex)]
                                                    )
                                                )
                                                
                                             }) {
                                                Text(text)
                                                    .bold()
                                            }
                                            .padding(.top, 7)
                                            .padding(.bottom, 7)
                                            .padding(.leading, 12)
                                            .padding(.trailing, 12)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                        })
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                }
                            }
                            
                        }
                        .frame(height: geometry.size.height*0.1)
                    }
                }
            }
        
        }
    }
}


protocol MessageLoader {
    var courseId: Int { get set };
    func loadNext(contextId: Int, initialHistoryId: Int, type: Int, question: String, botWrapper : BotWrapper)
}

struct BotMessageLoader : MessageLoader {
    var courseId: Int;
    
    func loadNext(contextId: Int, initialHistoryId: Int, type: Int, question: String, botWrapper: BotWrapper) {
        
        let body : [String : String] = [
            "courseId": String(courseId),
            "contextId": String(contextId),
            "initialHistoryId": String(initialHistoryId),
            "type": String(type),
            "question": question
        ]
        
        var data : String = "";
        var postError : String = ""
        
        botWrapper.submissionMessage = "";
        botWrapper.submissionFailed = false;
        botWrapper.submissionSucceded = false;
        
        post(route: "bot/getanswer", data: body) { result in
            switch result {
                case .success(let message):
                    data = message
                case .failure(let error):
                    postError = error.localizedDescription!
            }
            
            if ( postError != "" ) {
                botWrapper.submissionMessage = postError;
                botWrapper.submissionFailed = true;
            } else {
                do {
                    let decoder = JSONDecoder()
                    let message : BotMessage = try decoder.decode(BotMessage.self, from: data.data(using: .utf8)!)
                    
                    botWrapper.botMessages.append(message);
                    botWrapper.submissionSucceded = true;
                } catch {
                    print(data)
                    botWrapper.submissionMessage = "Failed for unknown reason: \(error.localizedDescription)"
                    botWrapper.submissionFailed = true;
                }
            }
        }
    }
}

class PreviewMessageLoader : MessageLoader {
    
    var userId: Int = 0;
    var courseId: Int = 0;
    
    var messages: [BotMessage]
    private (set) var i : Int32 = 0
    
    func increment () {
        OSAtomicIncrement32(&i)
    }
    
    init() {
        messages = Loader.load("messagestest.json")
    }
    
    func loadNext(contextId: Int, initialHistoryId: Int, type: Int, question: String, botWrapper: BotWrapper) {
        
        botWrapper.submissionMessage = "";
        botWrapper.submissionFailed = false;
        botWrapper.submissionSucceded = false;
        
        let message : BotMessage = messages[Int(i)];
        increment()
        
        botWrapper.botMessages.append(message);
        botWrapper.submissionSucceded = true;
    }
}

struct BotWrapper_Previews: PreviewProvider {
    
    static var previews: some View {
        let loader : MessageLoader =  PreviewMessageLoader()
        BotWrapper(loader: loader)
    }
}
