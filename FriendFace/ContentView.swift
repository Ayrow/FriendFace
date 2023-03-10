//
//  ContentView.swift
//  FriendFace
//
//  Created by Aymeric Pilaert on 10/03/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cachedUsers) { user in
                    HStack {
                        NavigationLink {
                            DetailView(user: user)
                        } label: {
                            Image(systemName: "person.fill")
                                .foregroundColor(user.isActive ? .green : .red)
                            Text(user.wrappedName)
                        }
                    }
                }
                .onDelete(perform: deleteUser)
                .navigationTitle("FriendFace")
                .task {
                    if(cachedUsers.isEmpty){
                        await getUsers()
                        await MainActor.run {
                            for user in users {
                                let newUser = CachedUser(context: moc)
                                newUser.name = user.name
                                newUser.id = user.id
                                newUser.isActive = user.isActive
                                newUser.age = Int16(user.age)
                                newUser.about = user.about
                                newUser.email = user.email
                                newUser.address = user.address
                                newUser.company = user.company
                                newUser.simplifiedDate = user.simplifiedDate
                                
                                for friend in user.friends {
                                    let newFriend = CachedFriend(context: moc)
                                    newFriend.id = friend.id
                                    newFriend.name = friend.name
                                    newFriend.user = newUser
                                }
                                try? moc.save()
                            }
                        }
                    }
                    
            }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
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
  
    func deleteUser(at offsets: IndexSet) {
        for offset in offsets {
            let user = cachedUsers[offset]
            
            moc.delete(user)
        }
        try? moc.save()
    }
    
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
