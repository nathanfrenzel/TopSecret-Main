//
//  ChatViewModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 9/5/21.
//

import Foundation
import Firebase


class ChatViewModel : ObservableObject {
    @Published var messages : [Message] = []
    @Published var chat : ChatModel?
     var userVM: UserAuthViewModel?

    
    init(){
        userVM?.fetchChats()
    }
    
    func setupUserVM(_ userVM: UserAuthViewModel){
        self.userVM = userVM
    }
    
    func readAllMessages(chatID: String){
        COLLECTION_CHAT.document(chatID).collection("Messages").addSnapshotListener { (snapshot, err) in
            
            if err != nil {
                print(err!.localizedDescription)
            }
            
            
            for doc in snapshot!.documentChanges {
                
                // adding when data is added
                
                if doc.type == .added {
                     let username = doc.document.get("username") as? String ?? ""
                     let text = doc.document.get("text") as! String
                    let timeStamp = doc.document.get("timeStamp") as? Date ?? Date()
                     let id = doc.document.documentID
                    
                    self.messages.append(Message(id: id, text: text, timeStamp: timeStamp, username: username))
                    

                }
                
            }
            
        }
    }
    
    
    func sendMessage(text: String,username: String,timeStamp: Date,chatID: String){
        COLLECTION_CHAT.document(chatID).collection("Messages").addDocument(data: ["text":text,"username":username,"timeStamp":timeStamp]) { (err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
        }
    }
    
    
}
