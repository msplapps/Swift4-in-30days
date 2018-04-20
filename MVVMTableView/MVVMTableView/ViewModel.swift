//
//  ViewModel.swift
//  MVVMTableView
//
//  Created by Reddy on 20/04/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}
extension ProfileViewModelItem {
    var rowCount: Int {
        return 1
    }
}

enum ProfileViewModelItemType {
    case nameAndPicture
    case about
    case email
    case friend
    case attribute
}

class ProfileViewModelNameItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .nameAndPicture
    }
    var sectionTitle: String {
        return "Main Info"
    }
    var pictureUrl: String
    var userName: String
    init(pictureUrl: String, userName: String) {
        self.pictureUrl = pictureUrl
        self.userName = userName
    }
}

class ProfileViewModelAboutItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .about
    }
    var sectionTitle: String {
        return "About"
    }
    var about: String
    
    init(about: String) {
        self.about = about
    }
}
class ProfileViewModelEmailItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .email
    }
    var sectionTitle: String {
        return "Email"
    }
    var email: String
    init(email: String) {
        self.email = email
    }
}
class ProfileViewModelAttributeItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .attribute
    }
    var sectionTitle: String {
        return "Attributes"
    }
    
    var rowCount: Int {
        return attributes.count
    }
    var attributes: [Attribute]
    init(attributes: [Attribute]) {
        self.attributes = attributes
    }
}
class ProfileViewModeFriendsItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .friend
    }
    var sectionTitle: String {
        return "Friends"
    }
    var rowCount: Int {
        return friends.count
    }
    var friends: [Friend]
    init(friends: [Friend]) {
        self.friends = friends
    }
}

public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class ProfileViewModel: NSObject {
    var items = [ProfileViewModelItem]()
    
     override init() {
        super.init()
        guard let data = dataFromFile("ServerData"), let profile = Profile(data: data) else {
            return
        }
        // initialization code will go here
        if let name = profile.fullName, let pictureUrl = profile.pictureUrl {
            let nameAndPictureItem = ProfileViewModelNameItem(pictureUrl: pictureUrl, userName: name)
            items.append(nameAndPictureItem)
        }
        if let about = profile.about {
            let aboutItem = ProfileViewModelAboutItem(about: about)
            items.append(aboutItem)
        }
        if let email = profile.email {
            let dobItem = ProfileViewModelEmailItem(email: email)
            items.append(dobItem)
        }
        let attributes = profile.profileAttributes
        // we only need attributes item if attributes not empty
        if !attributes.isEmpty {
            let attributesItem = ProfileViewModelAttributeItem(attributes: attributes)
            items.append(attributesItem)
        }
        let friends = profile.friends
        // we only need friends item if friends not empty
        if !profile.friends.isEmpty {
            let friendsItem = ProfileViewModeFriendsItem(friends: friends)
            items.append(friendsItem)
        }
    
    }
    
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        switch item.type {
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NameAndPictureCell.identifier, for: indexPath) as? NameAndPictureCell {
                cell.item = item
                return cell
            }
        case .about:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell {
                cell.item = item
                return cell
            }
        case .email:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.identifier, for: indexPath) as? EmailCell {
                cell.item = item
                return cell
            }
        case .friend:
            if let item = item as? ProfileViewModeFriendsItem,let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as? FriendCell {
                let friend = item.friends[indexPath.row]
                cell.item = friend
                return cell
            }
        case .attribute:
            if let item = item as? ProfileViewModelAttributeItem,let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: indexPath) as? AttributeCell {
                cell.item = item.attributes[indexPath.row]
                return cell
            }
        }
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch items[indexPath.section].type {
//            // do appropriate action for each type
//        }
    }
    
}
