//
//  LocationDescView.swift
//  SwiftMapApp
//
//  Created by 明先伟 on 2022/11/12.
//

import SwiftUI

//MARK: - === View ===
struct LocationDescView: View {
    
    let location:Location
    
    //MARK: - === Body ===
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading,spacing: 15){
                imageSection
                titleSection
            }
            
            Spacer()
            VStack {
                learnMoreButton
                nextButton
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:65)
            
        )
        .cornerRadius(10)
    }
}

//MARK: - === Extension ===
extension LocationDescView {
    // 图片
    private var imageSection: some View {
        ZStack {
            VStack{
                if let imageName = location.imageNames.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)
                        .cornerRadius(10)
                }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    // 名称和城市
    private var titleSection: some View {
        VStack (alignment: .leading,spacing: 6){
            Text(location.name)
                .font(.headline)
                .fontWeight(.black)
            Text(location.cityName)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
    
    // 更多按钮
    private var learnMoreButton: some View {
        Button {
            // TODO: 稍后添加点击事件
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 135,height: 35)
            
        }.buttonStyle(.borderedProminent)
    }
    
    //下一个按钮
    private var nextButton: some View {
        Button {
            // TODO: 稍后添加点击事件
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 135,height: 35)
            
        }.buttonStyle(.bordered)
    }
    
    
}


//MARK: - === Preview ===
struct LocationDescView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.vertical)
            LocationDescView(location: LocationsDataService.locations.first!)
                .padding()
                
        }
    }
}
