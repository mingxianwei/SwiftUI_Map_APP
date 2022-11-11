//
//  LocationMapAnnotationView.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/12.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack (spacing: 0){
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30,height: 30)
                .foregroundColor(.white)
                .font(.headline)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10,height: 10)
                .rotationEffect(Angle(degrees: 180))
                .foregroundColor(accentColor)
                .offset(y: -2)
                .padding(.bottom,40)
        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            LocationMapAnnotationView()
        }
    }
}
