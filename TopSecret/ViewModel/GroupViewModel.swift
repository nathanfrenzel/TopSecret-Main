//
//  CreateGroupViewModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

import Firebase


class GroupViewModel: ObservableObject {
    
    @Published var group : Group?
    @Published var groupChat : ChatModel?
    
    var userVM: UserAuthViewModel?
    
    
    
    init(){
        userVM?.fetchGroups()
    }
    
    func setupUserVM(_ userVM: UserAuthViewModel){
        self.userVM = userVM
        
    }
    
    func createChat(group: Group){
        
        
        
        let data = ["name": group.groupName ?? " ",
                    "memberAmount":group.memberAmount,
                    "dateCreated":Date(),
                    "users":[userVM?.user?.id]] as [String : Any]
        
        let chat = ChatModel(dictionary: data)
        
        COLLECTION_USER.document(userVM?.user?.id ?? " ").collection("Chat").addDocument(data: data)
        COLLECTION_USER.document(userVM?.user?.id ?? " ").collection("Groups").document(group.id ?? " ").collection("Chat").addDocument(data: data)
        
        
    }
    
    
    func joinGroup(publicID: String){
        
        
        //this finds the group in group list and adds user to its user list
        
        let groupQuery = COLLECTION_GROUP.whereField("publicID", isEqualTo: publicID)
        let userGroupQuery = COLLECTION_USER.document(userVM?.user?.id ?? " ").collection("Groups").whereField("publicID", isEqualTo: publicID)
        
        groupQuery.getDocuments { [self]  (querySnapshot, err) in
            if let err = err {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            if querySnapshot!.documents.count == 0 {
                print("unable to find group with code: \(publicID)")
            }
            
            for document in querySnapshot!.documents{
                
                let group = Group(dictionary: document.data())
                
                //updates the list of users
                document.reference.updateData(["users":FieldValue.arrayUnion([userVM?.user?.id ?? " "])])
                document.reference.updateData(["memberAmount": group.memberAmount+1])
                
                print("sucesfully added user to group")
                
                
            }
            
            
            
        }
        
        userGroupQuery.getDocuments { [self]  (querySnapshot, err) in
            if let err = err {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            if querySnapshot!.documents.count == 0 {
                print("unable to find group with code: \(publicID)")
            }
            
            for document in querySnapshot!.documents{
                let group = Group(dictionary: document.data())

                
                
                document.reference.updateData(["users":FieldValue.arrayUnion([userVM?.user?.id ?? " "]),"memberAmount": group.memberAmount+1])
                
                        }
            
            
        }
    }
    
    func leaveGroup(){
        let groupQuery = COLLECTION_GROUP.whereField("users", arrayContains: userVM?.user?.id ?? "")
        
        groupQuery.getDocuments { [self]  (querySnapshot, err) in
            if let err = err {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            
            for document in querySnapshot!.documents{
                
                let group = Group(dictionary: document.data())
                
                
                //updates the list of users
                document.reference.updateData(["users":FieldValue.arrayRemove([userVM?.user?.id ?? " "])])
                document.reference.updateData(["memberAmount": group.memberAmount-1])
                
                print("sucesfully removed user from group")
                
                
            }
        }
        
        
        
        
    }
    
    
    func createGroup(groupName: String, memberLimit: Int, dateCreated: Date, publicID: String){
        
        
        
        
        let data = ["groupName" : groupName,
                    "memberLimit" : memberLimit,
                    "publicID" : publicID,
                    "users" : [userVM?.user?.id] ,
                    "memberAmount": group?.memberAmount ?? 0
        ] as [String:Any]
        
        let group = Group(dictionary: data)
        createChat(group: group)
        
        
        
        COLLECTION_GROUP.document(group.id ?? " ").setData(data)
        //adds group to group db
        COLLECTION_USER.document(userVM?.user?.id ?? " ").collection("Groups").document(group.id ?? " ").setData(data){ _ in
            print("DEBUG: Sucessfully created group")
        }
        
        joinGroup(publicID: group.publicID ?? " ")
        
        
        
        
        
    }
    
    
    
    
    
    
    
}






