//
//  ContentView.swift
//  Belajar Swift4 IpungDev
//
//  Created by Muhammad Abdul Fattah on 22/07/22.
//

import SwiftUI

//MARK: - Content Data
struct ContentView: View {
  
  let data: [DataModel] = [
    
    DataModel(id: 1, productName: "Buku 1", productPhoto: "foto1", productPrice: 100000, location: "Kota Tangerang", ratingCount: 4, totalRating: 70),
    DataModel(id: 2, productName: "Buku 2", productPhoto: "foto2", productPrice: 200000, location: "Kota Bogor", ratingCount: 5, totalRating: 80),
    DataModel(id: 3, productName: "Buku 3", productPhoto: "foto3", productPrice: 300000, location: "Kota Jakarta", ratingCount: 5, totalRating: 75),
    DataModel(id: 4, productName: "Buku 4", productPhoto: "foto4", productPrice: 400000, location: "Kota Malang", ratingCount: 3, totalRating: 77),
    DataModel(id: 5, productName: "Buku 5", productPhoto: "foto5", productPrice: 500000, location: "Kota Surabaya", ratingCount: 5, totalRating: 90),
    DataModel(id: 6, productName: "Buku 6", productPhoto: "foto6", productPrice: 600000, location: "Kota Solo", ratingCount: 4, totalRating: 92),
    DataModel(id: 7, productName: "Buku 7", productPhoto: "foto7", productPrice: 700000, location: "Kota Bandung", ratingCount: 4, totalRating: 95),
    DataModel(id: 8, productName: "Buku 8", productPhoto: "foto8", productPrice: 800000, location: "Kota Medan", ratingCount: 2, totalRating: 97),
    DataModel(id: 9, productName: "Buku 9", productPhoto: "foto9", productPrice: 900000, location: "Kota Tegal", ratingCount: 4, totalRating: 99),
    DataModel(id: 10, productName: "Buku 10", productPhoto: "foto10", productPrice: 1000000, location: "Kota Tangsel", ratingCount: 5, totalRating: 70),
  ]
  
//  @State var inChart:Int = 0
  @ObservedObject var globalData = GlobalObject()
  
  //MARK: - Iterating View
  var body: some View {
//      Product()
    NavigationView{
      ScrollView{
        ForEach(data){ row in
          VStack(spacing: 10){
            Product(data: row, cartCount_dataModel: globalData)
          }
          .padding()
        }
      }
      .navigationTitle("List Buku")
      .navigationBarItems(
        trailing:
          HStack(spacing: 10){
            
            //Ngelempar data state ke binding
            NavigationLink(destination: DetailView(cartCount_detailView: globalData)){
              CartView(cartCount_View: globalData)
            }
            Button(action: {print("Button Profile Tapped")}){
              Image(systemName: "person.fill")
            }
          })
    }
    .accentColor(Color.secondary)
    //Biar dinamis pas rotate
    .navigationViewStyle(StackNavigationViewStyle())
  }

  
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .previewInterfaceOrientation(.portrait)
    }
}
//MARK: - Detail View
  
  struct DetailView: View{
    
    @ObservedObject var cartCount_detailView: GlobalObject
    var body: some View{
      NavigationView{
      Text("Detail")
          .navigationBarTitle("Detail")
          .navigationBarItems(
          trailing:
            HStack(spacing:20){
              CartView(cartCount_View: cartCount_detailView)
              Button(action: {print("ButtonTapped")}){
                Image(systemName: "person.fill")
              }

            }
          )
      }
    }
  }
//MARK: - Cart Object
struct CartView: View{
//  @Binding var jumlah: Int
  @ObservedObject var cartCount_View: GlobalObject
    var body: some View{
      ZStack {
        Image(systemName: "cart.fill")
        Text("\(self.cartCount_View.cartCount)")
          .foregroundColor(Color.white)
          .frame(width:10, height:10)
          .font(.body)
          .padding(5)
          .background(Color.red)
          .clipShape(Circle())
          .offset(x:10, y:-10)
      }
    }
  }
  
//MARK: Reusable Costum Card

struct Product: View{
  
  let data: DataModel
  
//  @Binding var jumlahProduk: Int
  @ObservedObject var cartCount_dataModel: GlobalObject
  
  var body: some View{
    VStack(alignment: .leading){
      ZStack(alignment: .topTrailing){
        Image(self.data.productPhoto)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: 200)
          .clipped()
        
        Button(action: {print("Button 1 pressed")}){
          Image(systemName: "heart")
            .padding()
          
        }
      }
      Text(self.data.productName)
        .font(.title)
        .bold()
        .padding(.leading)
        .padding(.trailing)
      Text("Rp \(self.data.productPrice)")
        .foregroundColor(Color.red)
        .font(.title)
        .bold()
        .padding(.leading)
        .padding(.trailing)

      HStack{
        Image(systemName: "mappin.circle")
        Text(self.data.location)
      }
      .padding(.leading)
      .padding(.trailing)
      
      HStack{
        HStack{
          ForEach(0..<self.data.ratingCount){
            items in
            Image(systemName: "star.fill")
              .foregroundColor(Color.yellow)
          }
          Image(systemName: "star.fill")
            .foregroundColor(Color.yellow)
        }
      }
      .padding(.leading)
      .padding(.trailing)
      
      addCart(cart: cartCount_dataModel)
      
    }
    .background(Color("warna"))
    .cornerRadius(15)
  }
}
}

// MARK: - Button "tambahkan Ke Keranjang"

struct addCart: View{
//  @Binding var jumlah: Int
  @ObservedObject var cart: GlobalObject
  
  var body: some View{
    Button(action: {
      self.cart.cartCount += 1
      print("Cart Added")
    }){
      HStack{
        Spacer()
        HStack{
          Image(systemName: "cart")
          Text("Tambahkan ke keranjang")
            .font(.callout)
            .padding()
        }
        Spacer()
      }
    }
    .background(Color.green)
    .foregroundColor(Color.white)
    .cornerRadius(10)
    .padding()
  }
}
