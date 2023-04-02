//
//  ContentView.swift
//  Belajar Swift IpungDev
//
//  Created by Muhammad Abdul Fattah on 20/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        Image("bg")
          .resizable()
          .edgesIgnoringSafeArea(.all)
        
        VStack(spacing:20){
          Logo()
          FormBox()
        }
        .padding(.all,20)
      }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Logo : View {
  var body: some View{
    VStack(spacing:20){
      
      Image(systemName : "hand.raised")
        .resizable()
        .frame(width : 100, height : 100)
        .background(Color("warnaKu"))
        .foregroundColor(Color.white)
        .padding()
        .background(Color("warnaKu"))
        .cornerRadius(20)
      
      Text("Belajar SwiftUI").foregroundColor(Color.white)
      
    }
  }
}

struct FormBox : View {
  @State var username: String = ""
  @State var password: String = ""
  
  var body: some View{
    VStack(alignment: .leading){
      
      Text("Username").font(.callout).bold()
      TextField("Username...", text:$username)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Text("Password").font(.callout).bold()
      SecureField("Password...", text:$password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Button(action: {print("Coba")}){
        HStack{
          Text("Sign In")
          Spacer()
        }
      }
      .padding()
      .background(Color.black)
      .cornerRadius(10)
      .foregroundColor(Color.white)
    }
    .padding(.all, 30)
      .background(Color.orange)
      .cornerRadius(10)
  }
}
