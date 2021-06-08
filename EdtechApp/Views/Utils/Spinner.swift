//
//  Spinner.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 27/05/2021.
//

import SwiftUI

struct Spinner: View {
    let style = StrokeStyle(lineWidth: 6, lineCap: .round)
    @State var animate = false
    let color1 = Color.gray
    let color2 = Color.gray.opacity(0.5)
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(gradient: .init(colors: [color1, color2]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),
                    style: style)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }.onAppear(){
            self.animate.toggle()
        }
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
