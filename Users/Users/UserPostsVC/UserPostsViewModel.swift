//
//  UserPostsViewModel.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation

class UserPostsViewModel {
    
    func getPosts(for userid:String, completion:@escaping(_ response:[Post])->()){
        
        let postsURL = AppURL.getPosts + userid
        NetworkManager.getPosts(postsURL, success: { (response) in
            DispatchQueue.main.async {
                completion(response)
            }
        }) { (error) in
            print(error)
        }
        
    }
    
}
