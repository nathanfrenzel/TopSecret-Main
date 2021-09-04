//
//  CreateGroupViewModel.swift
//  TopSecret
//
//  Created by Bruce Blake on 8/31/21.
//

import SwiftUI

import Firebase


class GroupViewModel: ObservableObject {
    
    
    @Published var groups: [Group] = []
    
    var userVM: UserAuthViewModel?
    
    
    
    init(){
        userVM?.fetchUser()
       
    }
    
    func setupUserVM(_ userVM: UserAuthViewModel){
        self.userVM = userVM
    }
    
    func joinGroup(publicID: String, userID: User.ID){

        let query = COLLECTION_GROUP.whereField("publicID", isEqualTo: publicID)
        
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            for document in querySnapshot!.documents{


                document.reference.updateData(["users":FieldValue.arrayUnion([userID ?? " "])])
                print("sucesfully added user to group")
                COLLECTION_USER.document(userID ?? " ").collection("groups").addDocument(data: document.data()) { (err) in
                    if let err = err{
                        print("DEBUG: \(err.localizedDescription)")
                        return
                    }
                    print("sucesfully added group to user account")
                }
            }
        }


      
    }
    
    func createGroup(groupName: String, memberLimit: Int, dateCreated: Date, publicID: String, user: [User.ID]){
        
        
        
        
        let data = ["groupName" : groupName,
                    "memberLimit" : memberLimit,
                    "publicID" : publicID,
                    "users" : user 
        ] as [String:Any]
        
        let group = Group(dictionary: data)

        
        
        //adds user specific group
        COLLECTION_USER.document(user[0] ?? " ").collection("groups").addDocument(data: data) { (err) in
            if let err = err{
                print("DEBUG: \(err.localizedDescription)")
                return
            }
        }

        //adds group to group db
        COLLECTION_GROUP.document(group.id ?? " ").setData(data){ _ in
            print("DEBUG: Sucessfully created group")
        }
        
        self.userVM?.fetchUser()

        
    }
    
    
    
   

        

    }
    
    



