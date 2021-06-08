//
//  Subjects.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 07/06/2021.
//

import SwiftUI

struct Subjects: View {
    @State var loader : SubjectsLoader
    
    @State var submissionFailed : Bool = false;
    @State var submissionSucceded : Bool = false;
    @State var submissionMessage : String = "";
    @State var subjects : [SubjectSection]?;
    
    var body: some View {
        VStack {
            if ( !submissionFailed && !submissionSucceded ) {
                Spinner()
            } else {
                VStack() {
                    ForEach(subjects!, id: \.self) { subject in
                        VStack(alignment: .leading) {
                            Text(subject.title)
                            WrappingStack(content: subject.courses.map{ course in
                                Text(course.title)
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                    .padding(.leading, 15)
                                    .padding(.trailing, 15)
                                    .overlay(
                                        Capsule(style: .continuous)
                                        .stroke(Color.blue)
                                    )
                                    .font(.system(size: 12))
                            })
                        }
                    }
                }
            }
        }.onAppear() {
            if ( subjects == nil ) {
                loader.load(subjects: self)
            }
        }

    }
}

protocol SubjectsLoader {
    func load(subjects: Subjects)
}

class PreviewSubjectsLoader : SubjectsLoader {
    func load(subjects:Subjects) {
        subjects.submissionMessage = "";
        subjects.submissionFailed = false;
        subjects.submissionSucceded = false;
        
        let subjectsData : [SubjectSection]  = Loader.load("subjects.json");
        
        subjects.subjects = subjectsData;
        subjects.submissionSucceded = true;
    }
}

struct Subjects_Previews: PreviewProvider {
    static var previews: some View {
        let loader : SubjectsLoader = PreviewSubjectsLoader()
        Subjects(loader: loader)
    }
}
