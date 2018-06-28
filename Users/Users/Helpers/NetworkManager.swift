//
//  NetworkManager.swift
//  Users
//
//  Created by PurushothamReddy on 27/06/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    //GetData
    class func getuser(_ strURL:String, success:@escaping([User]) -> Void,failure:@escaping(Error) ->Void){
        Alamofire.request(strURL).responseJSON { (response) in
            if response.result.isSuccess{
                guard let data = response.data else{
                    return
                }
                do {
                    let users = try JSONDecoder().decode([User].self, from:data)
                    success(users)
                }catch let error{
                    print(error.localizedDescription)
                }
               
            }
            if response.result.isFailure{
                let error:Error = response.result.error!
                failure(error)
            }
        }
}
    
    
    class func getPosts(_ strURL:String, success:@escaping([Post]) -> Void,failure:@escaping(Error) ->Void){
        Alamofire.request(strURL).responseJSON { (response) in
            if response.result.isSuccess{
                guard let data = response.data else{
                    return
                }
                do {
                    let posts = try JSONDecoder().decode([Post].self, from:data)
                    success(posts)
                }catch let error{
                    print(error.localizedDescription)
                }
                
            }
            if response.result.isFailure{
                let error:Error = response.result.error!
                failure(error)
            }
        }
    }
    

}
