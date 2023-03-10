//
//  DetailView.swift
//  FriendFace
//
//  Created by Aymeric Pilaert on 10/03/2023.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
            List {
                Section {
                    Text("Registered: \(user.simplifiedDate)")
                    Text("Age: \(user.age)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                    Text("Works for: \(user.company)")
                } header: {
                    Text("Basic Info")
                }
                
                Section {
                    Text(user.about)
                } header: {
                    Text("About")
                }
                
                Section {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                } header: {
                    Text("Friends")
                }
            }
            .toolbar {
                Button {
                    //
                } label: {
                    Label("Delete User", systemImage: "trash")
                }

            }
            .navigationTitle(user.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(user: User(id: UUID(), name: "Johnny", age: 12, company: "Apple", about: "This is about me", isActive: true, email: "apple@hotmail.com", registered: Date.now, friends: [], address: "566 route des vignes", tags: ["bananas"]))
    }
}
