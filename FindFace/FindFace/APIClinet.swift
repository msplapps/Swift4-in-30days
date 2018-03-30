//
//  APIClinet.swift
//  FindFace
//
//  Created by Reddy on 29/03/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

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
    
    class func centerImageforFace(imageview:UIImageView){
        let context = CIContext(options:nil)
        let options = [CIDetectorAccuracy:CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options)
        
        let faceImage = imageview.image
        let ciImage = CIImage(cgImage:(faceImage!.cgImage!))
        let features = detector?.features(in: ciImage)
        
        if features!.count > 0 {
            var face:CIFaceFeature!
            for rect in features! {
                face = rect as! CIFaceFeature
            }
            var faceRectWithExtendedBounds = face.bounds
            faceRectWithExtendedBounds.origin.x -= 20
            faceRectWithExtendedBounds.origin.y -= 30
            
            faceRectWithExtendedBounds.size.width += 40
            faceRectWithExtendedBounds.size.width += 60
            
            let x = faceRectWithExtendedBounds.origin.x / faceImage!.size.width
            let y = (faceImage!.size.height - faceRectWithExtendedBounds.origin.y - faceRectWithExtendedBounds.size.height) / faceImage!.size.height
            
            let widthFace = faceRectWithExtendedBounds.size.width / faceImage!.size.width
            let heightFace = faceRectWithExtendedBounds.size.height / faceImage!.size.height
            
            imageview.layer.contentsRect = CGRect(x: x, y: y, width: widthFace, height: heightFace)
        }
        
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
