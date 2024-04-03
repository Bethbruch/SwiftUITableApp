//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Bruch, Beth on 4/1/24.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Roppolos", neighborhood: "Downtown", desc: "Nobody is doing pizza in Downtown Austin like Roppolos. This Austin classic is beloved by locals and tourists alike. The sicilian style pizza is located on 6th street, so get yourself a slice and check out austins more popular bar hopping streets.",  lat: 30.267568101896323, long: -97.7396985023326, imageName: "rest1"),
    Item(name: "Franklin BBQ", neighborhood: "Downtown", desc: "It's criminal to come to Austin and not eat some TX BBQ. Franklin BBQ is one of Austin's more popular BBQ restaurants and for good reason. Their meat is barked and smoked to perfection. Their menu isn't the largest but we don't fuss about our meet here in Texas. If you're interested in checking Franklin BBQ out try and get there before 1pm, one they're out of meat they close up shop and the line is not forgiving. ", lat: 30.270291763574594, long: -97.73138481767585
, imageName: "rest2"),
    Item(name: "Gus’s World Famous Fried Chicken", neighborhood: "Downtown", desc: "Nobody is cookin' up chicken like my man Gus. If you're on the hunt for some good ol' fashion soul food, this is the place for you. Their chicken is breaded and fried to perfection and they have some of the best collard green I've ever had! ", lat: 30.263730074787198, long: -97.74169135815359
   , imageName: "rest3"),
    Item(name: "Lick Honest Ice Cream", neighborhood: "South Lamar", desc: "Want a sweet treat that's just as weird as austin? Lick honest Ice Cream has a menu of evergreen and seasonal flavors that take a unique take on your favorite flavors. My personal favorite combo is vanilla and honey with mint and beet! ", lat: 30.25578631793456, long: -97.76262715952241, imageName: "rest4"),
    Item(name: "Soto", neighborhood: "South Lamar", desc: "Need a bite before heading to Alamo for your movie? Head over to soto for some killer sushi! This Upscale asian spot is perfect for anyone looking to enjoy the more high end food Austin has to offer.",  lat: 30.255823387541348, long: -97.76205853122367, imageName: "rest5")
]
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let neighborhood: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }



struct ContentView: View {
    // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
              @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.263730074787198, longitude: -97.74169135815359), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            } // end internal VStack
                        } // end HStack
                    } // end NavigationLink
                } // end List
                //add this code in the ContentView within the main VStack.
                            Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            } // end map
                            .frame(height: 300)
                            .padding(.bottom, -30)
            } // end VStack
            .listStyle(PlainListStyle())
                    .navigationTitle("SXSW Eats")
                } // end NavigationView
            } // end body
}



struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
          @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
       let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: 200)
               Text("Neighborhood: \(item.neighborhood)")
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
               // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                     Map(coordinateRegion: $region, annotationItems: [item]) { item in
                       MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                           Image(systemName: "mappin.circle.fill")
                               .foregroundColor(.red)
                               .font(.title)
                               .overlay(
                                   Text(item.name)
                                       .font(.subheadline)
                                       .foregroundColor(.black)
                                       .fixedSize(horizontal: true, vertical: false)
                                       .offset(y: 25)
                               )
                       }
                   } // end Map
                       .frame(height: 300)
                       .padding(.bottom, -30)
                   } // end VStack
                    .navigationTitle(item.name)
                    Spacer()
        } // end body
     } // end DetailView



#Preview {
    ContentView()
}
