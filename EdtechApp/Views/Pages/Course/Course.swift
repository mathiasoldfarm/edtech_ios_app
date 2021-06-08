//
//  Course.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 27/05/2021.
//

import SwiftUI

struct Course: View {
    var loader : MessageLoader;
    private var course : Int = 1
    
    init (messageLoader: MessageLoader) {
        self.loader = messageLoader
    }
    
    @State private var fetchSucceded: Bool = false
    @State private var fetchFailed: Bool = false
    
    @State private var fetchMessage: String = ""
    @State private var sections: [CourseMenuItemData] = []
    
    var body: some View {
        CourseSectionsMenu(_sections: sections) {
            VStack {
                if (fetchSucceded) {
                    VStack{
                        HStack{
                            Button(action: {
                                print("Hello")
                            }) {
                                BotWrapper(loader: loader)
                            }
                        }
                    }
                } else if fetchFailed {
                    Text(fetchMessage).foregroundColor(.red)
                } else {
                    Text("Loading")
                }
            }
            .onAppear() {
                getData()
            }
        }
    }
    
    func getData() -> Void {
        //TESTER:
        
        /*
        get(route: "views/learn/brøker") { result in
            fetchFailed = false
            fetchSucceded = false
            switch result {
                case .success(let data):
                    fetchSucceded = true
                    sections = data
                case .failure(let error):
                    fetchFailed = true
                    fetchMessage = error.localizedDescription!
            return
            }
        }
        */
        sections = Loader.load("coursetest.json")
        fetchSucceded = true;
    }
}

struct Course_Previews: PreviewProvider {
    static var previews: some View {
        let loader : MessageLoader = PreviewMessageLoader()
        
        Group {
            Course(messageLoader: loader)
        }
    }
}
