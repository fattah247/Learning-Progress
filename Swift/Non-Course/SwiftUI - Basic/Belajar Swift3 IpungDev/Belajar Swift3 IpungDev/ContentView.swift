//
//  ContentView.swift
//  Belajar Swift3 IpungDev
//
//  Created by Muhammad Abdul Fattah on 21/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack{
        TabView{
          Home()
            .tabItem {
              Image(systemName: "house.fill")
              Text("Home")
              
            }
          Home()
            .tabItem {
              Image(systemName: "paperplane.fill")
              Text("Explore")
              
            }
          Home()
            .tabItem {
              Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 40, height: 40)
              
            }
          Home()
            .tabItem {
              Image(systemName: "tray.fill")
              Text("Subsription")
              
            }
          Home()
            .tabItem {
              Image(systemName: "play.rectangle.on.rectangle")
              Text("Collection")
            }
        }.accentColor(.red)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
  var body: some View{
    
    //Costum navigation bar
    NavigationView{
      Content()
      
        .navigationBarItems(
          leading:
            HStack{
              Button(action: {print("Button Pressed")}){
                Image("logo")
                  .renderingMode(.original)
                  .resizable()
                  .frame(width: 90, height: 20)
              }
            },
          trailing:
            HStack(spacing: 10) {
              Button(action: {print("Button 2 pressed")}){
                Image(systemName: "tray.full")
                  .foregroundColor(Color.secondary)
              }
              Button(action: {print("Button 3 pressed")}){
                Image(systemName: "video.fill")
                  .foregroundColor(Color.secondary)
              }
              Button(action: {print("Button 4 pressed")}){
                Image(systemName: "magnifyingglass")
                  .foregroundColor(Color.secondary)
              }
              Button(action: {print("Button 4 pressed")}){
                Image("profile")
                  .renderingMode(.original)
                  .resizable()
                  .frame(width: 20, height: 20)
                  .clipShape(Circle())
              }
            }
        ).navigationBarTitle("", displayMode: .inline)
    }.navigationViewStyle(StackNavigationViewStyle())
}
}

struct Content: View{
  var body: some View{
    List{
      CellContent(imageContent: "content1", profileContent: "profile", title: "Halalnya berfilsafat", description: "Kata siapa Filsafat... - 300x views", duration: "10:05")
      CellContent(imageContent: "content2", profileContent: "profile", title: "Kata-kata benar #1", description: "Apa definisi kebenaran... - 300x views", duration: "20:05")
      CellContent(imageContent: "content3", profileContent: "profile", title: "Kata-kata benar #2", description: "Siapa penentu kebenara... - 300x views", duration: "30:05")

  }
}

//Komponen untuk Cell
struct CellContent: View{
  
  var imageContent: String
  var profileContent: String
  var title: String
  var description: String
  var duration: String
  
  var body: some View{
      VStack{
        ZStack(alignment: .bottomTrailing){
          Image(imageContent)
            .resizable()
            .aspectRatio(contentMode: .fill)
          
          Text(duration)
            .padding(.all, 5)
            .foregroundColor(Color.white)
            .background(Color.black)
            .cornerRadius(5)
            .padding(.trailing, 5)
            .padding(.bottom, 5)
        }
        HStack(spacing: 20){
          Image(profileContent)
    //            .renderingMode(.original)
            .resizable()
            .frame(width: 30, height: 30)
            .clipShape(Circle())
          VStack(alignment: .leading){
            Text(title).font(.headline)
            HStack {
              Text(duration).font(.caption)
            }
          }
          Spacer()
          Image(systemName: "list.bullet")
        }
      }
    }
  }
}
