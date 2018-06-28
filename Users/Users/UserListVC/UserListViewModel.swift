//
//  UserListViewModel.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation
import UIKit

class UserListViewModel {
    
    func getUsers(completion:@escaping(_ response:[User])->()){
        
        NetworkManager.getuser(AppURL.getUsers, success: { (response) in
            DispatchQueue.main.async {
                completion(response)
            }
        }) { (error) in
        print(error)
        }
        
        }
        
}

