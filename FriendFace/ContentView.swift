//
//  ContentView.swift
//  FriendFace
//
//  Created by Aymeric Pilaert on 10/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                HStack {
                    NavigationLink {
                        //
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundColor(user.isActive ? .green : .red)
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if(users.isEmpty){
                    await getUsers()
                }
                }
            }
        }
    
        
    func getUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application.json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
                
        } catch {
            print("Invalid data")
        }
        
    }
  
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
