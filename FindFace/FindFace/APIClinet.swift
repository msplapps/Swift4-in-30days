//
//  APIClinet.swift
//  FindFace
//
//  Created by Reddy on 29/03/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//

import Foundation
import UIKit

/*
 // Map names from Response
struct MyGitHub: Codable {
    
    let name: String?
    let location: String?
    let followers: Int?
    let avatarUrl: URL?
    let repos: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case location
        case followers
        case repos = "public_repos"
        case avatarUrl = "avatar_url"
        
    }
}
*/

struct ToDo:Codable {
    var sourceURL:String?
    
    init?(json:[String: Any]) {
        guard let query = json["query"] as? [String:Any] else{
          //  print("query error")
            return
        }
         print("query:" + query.description)
        guard let pages = query["pages"] as? [String:Any]else {
          //  print("pages error")
            return
        }
        //   print("Pages:" + pages.description)
        
        let firstKey = pages.keys.first
        
       
        guard let singlePage = pages[firstKey!] as? [String:Any] else {
         //   print("singlePage error")
            return
        }
        guard let thumbnail = singlePage["thumbnail"] as? [String:Any] else {
        //    print("thumbnail error")
            return
        }
     
     //   print("thumbnail:" + thumbnail.description)
        
        let source = thumbnail["source"] as? String
        
        print("source url:" + source!)
        self.sourceURL = source
    }
}

class APIClient: NSObject {
    
    
    typealias CompletionHandler = (_ image:UIImage?, _ success:Bool) -> ()
    
    class func faceForPerson(person:String, completionHandler:@escaping CompletionHandler){
        
    let escapedString = person.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(escapedString!)&prop=pageimages&format=json&pithumbsize=800")
    
    
    let task = URLSession.shared.dataTask(with: url!) {
        (data, response, error) in
        if error != nil {
            print("Got error:")
            print(error!.localizedDescription)
            completionHandler(nil, false)
        }else if let data = data,let response = response as? HTTPURLResponse,response.statusCode == 200 {
          // print(response)
            
            
    /*
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(query.self, from: data)
                print(gitData.thumbnail)
                
            } catch let err {
                print("Error:", err)
            }
    */
            
   
            guard let wikiDict = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("error trying to convert data to JSON")
                return
            }

            
            let todo = ToDo(json: wikiDict)
       //     print(todo?.sourceURL ?? "No URL Found")
            guard let url = todo?.sourceURL else {
                 completionHandler(nil, false)
                return
            }
            let fileUrl = URL(string:url)
            if let data = try? Data(contentsOf: fileUrl!)
            {
                let image = UIImage(data: data)!
                completionHandler(image, true)
            }
          //  completionHandler(nil, false)
            }
           
        
    }

    task.resume()
        
    }
    
    fileprivate func getImage(url:String) -> UIImage{
    
    let fileUrl = URL(string:url)
    var image: UIImage?
    
    if let data = try? Data(contentsOf: fileUrl!)
    {
        image = UIImage(data: data)!
    }

    return image!
    }
    
    
}
