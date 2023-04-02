//
//  ContentView.swift
//  Belajar Swift2 IpungDev
//
//  Created by Muhammad Abdul Fattah on 21/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationView{
        Form{
          
          //Section Profile
          Section(){
            NavigationLink(destination: About()){
              HStack{
                Image("profile")
                  .resizable()
                  .frame(width: 50, height: 50)
                  .clipShape(Circle())
                
                //Nama dan Status
                VStack(alignment: .leading){
                  Text("M. A. Fattah").font(.headline)
                  Text("iOS Dev").font(.caption)
                }
              }
              .padding(.top, 10)
              .padding(.bottom, 10)
            }
            
          }
          
          //Pengaturan
          Section(header: Text("Pengaturan Umum")){
            NavigationLink(destination: About()){
              HStack(spacing:20){
                Image(systemName: "star.fill")
                  .frame(width:35, height:35)
                  .background(Color.orange)
                  .cornerRadius(10)
                  .foregroundColor(Color.white)
                Text("Pesan Berbintang")
              }
            }
 
            NavigationLink(destination: About()){
              HStack(spacing:20){
                Image(systemName: "tv")
                  .frame(width:35, height:35)
                  .background(Color.green)
                  .cornerRadius(10)
                  .foregroundColor(Color.white)
                Text("Whatsapp Web")
              }
            }

          }
          
          //Pengaturan
          Section(header: Text("Pengaturan Akun")){
            NavigationLink(destination: About()){
              HStack(spacing:20){
                Image(systemName: "person")
                  .frame(width:35, height:35)
                  .background(Color.blue)
                  .cornerRadius(10)
                  .foregroundColor(Color.white)
                Text("Akun")
            }
   
            }
            NavigationLink(destination: About()){
              HStack(spacing:20){
                Image(systemName: "phone.circle")
                  .frame(width:35, height:35)
                  .background(Color.green)
                  .cornerRadius(10)
                  .foregroundColor(Color.white)
                Text("Chat")
              }
            }
          }
        }
      }.navigationTitle("Setting")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct About: View{
  var body: some View{
    Text("Halaman About")
  }
  
}
