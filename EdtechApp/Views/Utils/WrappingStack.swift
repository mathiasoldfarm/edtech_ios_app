//
//  WrappingStack.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 31/05/2021.
//

import SwiftUI

struct WrappingStack<Content>: View where Content : View {
    var content: [Content]
    
    var body: some View {
        GeometryReader { geometry in
            WrappingElements(content: content ,screenwidth: geometry.size.width)
        }
    }
}

struct WrappingElements<Content>: View where Content : View {
    var content: [Content]
    var screenwidth: CGFloat = 0;
    
    var lanes: [[Int]] {
        var newLanes : [[Int]] = []
        var currentLaneWidth: CGFloat = 0;
        var currentElementWidth: CGFloat = 0;
        var currentLane: [Int] = []
        for i in 0..<content.count {
            currentElementWidth = UIHostingController(rootView: content[i])
                .view.intrinsicContentSize.width;
            
            if ( currentLaneWidth + currentElementWidth > screenwidth ) {
                newLanes.append(currentLane);
                currentLane = [i]
                currentLaneWidth = currentElementWidth;
            } else {
                currentLaneWidth += currentElementWidth
                currentLane.append(i)
            }
        }
        newLanes.append(currentLane);
        
        return newLanes;
    };
    
    
    var body: some View {
        VStack(alignment: .leading) {
            //Spacer()
            ForEach(lanes, id: \.self) { row in
                HStack(alignment: .bottom) {
                    ForEach(row, id: \.self) { index in
                        content[index]
                    }
                }
            }
        }
    }
}

struct WrappingStack_Previews: PreviewProvider {
    
    static var previews: some View {
        WrappingStack(content: ["1 Sure, let's go!", "2 Sure, let's go!", "3 Sure, let's go!", "4 Sure, let's go!"].map{text in
            Button(action: {
                print(text)
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
}
