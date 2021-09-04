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
        

        //this finds the group in group list and adds user to its user list
        let groupQuery = COLLECTION_GROUP.whereField("publicID", isEqualTo: publicID)

        
        
        groupQuery.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            if querySnapshot!.documents.count == 0 {
                print("unable to find group with code: \(publicID)")
            }
            
            for document in querySnapshot!.documents{


                //updates the list of users
                document.reference.updateData(["users":FieldValue.arrayUnion([userID ?? " "])])
                print("sucesfully added user to group")
                
             
            }
        }
        
        userVM?.fetchUser()
      
    }
    
    func createGroup(groupName: String, memberLimit: Int, dateCreated: Date, publicID: String, user: [User.ID]){
        
        
        
        
        let data = ["groupName" : groupName,
                    "memberLimit" : memberLimit,
                    "publicID" : publicID,
                    "users" : user 
        ] as [String:Any]
        
        let group = Group(dictionary: data)

        
        

        //adds group to group db
        COLLECTION_GROUP.document(group.id ?? " ").setData(data){ _ in
            print("DEBUG: Sucessfully created group")
        }
        
        joinGroup(publicID: publicID, userID: user[0])

        self.userVM?.fetchUser()

        
    }
    
    
    
   

        

    }
    
    



