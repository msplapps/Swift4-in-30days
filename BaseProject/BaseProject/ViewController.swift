//
//  ViewController.swift
//  BaseProject
//
//  Created by Reddy on 12/03/18.
//  Copyright © 2018 CleanHarbors. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    getDatafromURl()
   //     getDataWithSwiftyJSON()
        
   //     GetDataWithWrapper()
        
    //    checkDecoder()
        
        checkCHI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func checkDecoder(){
        
        struct Swifter: Decodable {
            let fullName: String
            let id: Int
            let twitter: URL
        }
        
        struct MoreComplexStruct: Decodable {
            let swifter: Swifter
            let lovesSwift: Bool
        }
        
        let json = """
{
    "swifter": {
        "fullName": "Federico Zanetello",
        "id": 123456,
        "twitter": "http://twitter.com/zntfdr"
    },
    "lovesSwift": true
}
""".data(using: .utf8)! // our data in native format
        do{
        let myMoreComplexStruct = try JSONDecoder().decode(MoreComplexStruct.self, from: json)
             print(myMoreComplexStruct.swifter) // decoded!!!!!
        }catch{
            print("error")
        }
        
       
    }
    
    
    func checkCHI(){
        
        let json = """
{
   "status":{
      "SUCCESS":true,
      "Message":null,
      "ErrorDescription":""
   },
   "branches":[
      {
         "Name":"MU",
         "Description":"Murphy's Waste Oil Facility"
      },
      {
         "Name":"RU",
         "Description":"So. Portland, ME Oil Facility"
      },
      {
         "Name":"COH",
         "Description":"Cohoes, NY (Albany/Colonie)"
      },
      {
         "Name":"ON",
         "Description":"Newark, NJ Oil Facility"
      }
   ]
}
""".data(using: .utf8)! // our data in native format
        
        
        struct statusST:Decodable{
            var SUCCESS:Bool
            var Message:String
            var ErrorDescription:String
        }
        
        struct branchList:Decodable {
            var Name:String
            var Description:String
            
        }
        
        struct resData:Decodable {
            var status:statusST
            var branches:[branchList]
        }
        
        do{
            let myMoreComplexStruct = try JSONDecoder().decode(resData.self, from: json)
           // print(myMoreComplexStruct.branches) // decoded!!!!!
            print(myMoreComplexStruct.status)
        }catch{
            print("error")
            showDebugAlert(error: error)
        }
        
        
        
    }
    
   //since the enableDebug parameter takes a default value, you don't even need to bother passing it through the initializer's call, that's done behind the scenes
    
    func showDebugAlert(error:Error){
        let alert = UIAlertController(title: "Oops", message: "Feed could not be loaded.\nTry again later.", error: error)
        present(alert, animated: true, completion: nil)
    }
    
    

    
    func getDatafromURl(){
        Alamofire.request("https://api.androidhive.info/contacts/").responseData { (resData) in
            print(resData.result.value!)  //data in bytes
            let strOutput = String(data : resData.result.value!, encoding : String.Encoding.utf8)
            print(strOutput!)  // encoded data
        }
    }
    
    func getDataWithSwiftyJSON(){
        Alamofire.request("https://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print("swiftyJson: \(swiftyJsonVar)")
                if let resData = swiftyJsonVar["contacts"].arrayObject{
                    let arryres = resData as! [[String:AnyObject]]
                     print("arryres: \(arryres)")
                    var phone = arryres[0]["phone"] as! [String:AnyObject]
                    print("phone: \(phone["mobile"]!)")
            }
        }
    }
    }
    
    func GetDataWithWrapper(){
        let urlStr = "https://api.androidhive.info/contacts/"
        AFWrapper.requestGetURL(urlStr, success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }

        
    }

}

extension ViewController {
    
    struct Contact: Codable {
        var id : String
        var name : String
        var email : String
        var address : String
        var gender : String
        var phone : Phone
    }
    
    struct Phone: Codable {
        var mobile : String
        var home : String
        var office : String
    }
}

