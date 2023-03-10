//
//  DetailView.swift
//  FriendFace
//
//  Created by Aymeric Pilaert on 10/03/2023.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    let user: CachedUser
    
    var body: some View {
            List {
                Section {
                    Text("Registered: \(user.wrappedSimplifiedDate)")
                    Text("Age: \(user.age)")
                    Text("Email: \(user.wrappedEmail)")
                    Text("Address: \(user.wrappedAddress)")
                    Text("Works for: \(user.wrappedCompany)")
                } header: {
                    Text("Basic Info")
                }
                
                Section {
                    Text(user.wrappedAbout)
                } header: {
                    Text("About")
                }
                
                Section {
                    ForEach(user.friendsArray) { friend in
                        Text(friend.wrappedName)
                    }
                } header: {
                    Text("Friends")
                }
            }
            .toolbar {
                Button {
                    showingAlert = true
                } label: {
                    Label("Delete user", systemImage: "trash")
                }

            }
            .navigationTitle(user.wrappedName)
            .navigationBarTitleDisplayMode(.inline)
            .alert("Are your sure?", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) {
                    deleteUser()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    
    func deleteUser() {
        moc.delete(user)
        dismiss()
    }
    
}

