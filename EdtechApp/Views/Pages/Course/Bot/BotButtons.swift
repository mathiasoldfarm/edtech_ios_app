//
//  BotButton.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 31/05/2021.
//

import SwiftUI

struct BotButtons: View {
    private var buttonTexts: [String];
    private var historyId: Int;
    private var contextId: Int;
    var loader : MessageLoader
    @Binding var botMessages: [BotMessage]
    @Binding var userMessages: [UserMessage]
    @Binding var messageData: [MessageSection]
    
    @Binding var submissionFailed : Bool;
    @Binding var submissionSucceded : Bool;
    @Binding var submissionMessage : String;
    
    init(texts: [String], botHistoryId: Int, botContextId: Int, messageLoader: MessageLoader, botMessages: Binding<[BotMessage]>, userMessages: Binding<[UserMessage]>, messageData: Binding<[MessageSection]>, submissionFailed: Binding<Bool>, submissionSucceded: Binding<Bool>, submissionMessage: Binding<String>) {
        buttonTexts = texts;
        historyId = botHistoryId;
        contextId = botContextId;
        loader = messageLoader
        self._botMessages = botMessages
        self._userMessages = userMessages
        self._messageData = messageData
        self._submissionFailed = submissionFailed
        self._submissionSucceded = submissionSucceded
        self._submissionMessage = submissionMessage
    }
    
    var body: some View {
        HStack {
            WrappingStack(content: buttonTexts.map { text in
                Button(action: {
                    let botIndex : Int = botMessages.count
                    let userIndex : Int = userMessages.count
                    let nMessages: Int = messageData.count
                    
                    do {
                        let nextBotMessage : BotMessage = try loader.loadNext(contextId: contextId, initialHistoryId: historyId, type: 0, question: text)
                        botMessages.append(nextBotMessage)
                        
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
                        
                        submissionSucceded = true;
                    } catch MessageLoadingError.loadingError(let message) {
                        submissionMessage = message;
                        submissionFailed = true;
                    } catch  {
                        submissionMessage = error.localizedDescription;
                        submissionFailed = true;
                    }                }) {
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
    }
}

struct BotButton_Previews: PreviewProvider {
    @State static var botMessages: [BotMessage] = []
    @State static var userMessages: [UserMessage] = []
    @State static var messageData: [MessageSection] = []
    
    @State static var submissionFailed : Bool = false;
    @State static var submissionSucceded : Bool = true;
    @State static var submissionMessage : String = "";
    
    static var previews: some View {
        let loader : MessageLoader = PreviewMessageLoader()
        
        BotButtons(texts: ["Sure, let's go!", "Sure, let's go!", "Sure, let's go!", "Sure, let's go!"], botHistoryId: 0, botContextId: 0, messageLoader: loader, botMessages: $botMessages, userMessages: $userMessages, messageData: $messageData, submissionFailed: $submissionFailed, submissionSucceded: $submissionSucceded, submissionMessage: $submissionMessage)
    }
}
