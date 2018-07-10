//
//  ViewController.swift
//  TextViewAutoSizing
//
//  Created by PurushothamReddy on 05/07/18.
//  Copyright © 2018 Purushotham. All rights reserved.
//

import UIKit
struct Employee {
    var name:String
    var address:String
    var departmemt:String
}
class HTMLElement {
    var name:String
    var text:String
    
    init(name:String, text:String) {
        self.name = name
        self.text = text
    }
    
  lazy var asHTML:() -> String = { [weak self] in
    guard let this = self else{return ""}
        return "<\(this.name)>\(this.text)<\(this.name)>"
    }
    
    deinit {
        print("HTMLelement \(name) being deallocated")
    }
}

class ViewController: UIViewController {
    var textView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
   //     testGrouping()
        var paraGraph:HTMLElement? = HTMLElement(name: "p", text: "some sample text")
  //      paraGraph?.asHTML()
        print(paraGraph?.asHTML() ?? "")
        paraGraph = nil
    }
    
    
    
    
    
    func testGrouping(){
        
        let emplyees = [
            Employee(name: "raj", address: "Hyd", departmemt: "Dev"),
            Employee(name: "vinod", address: "CLH", departmemt: "iOS"),
            Employee(name: "kiran", address: "CLH", departmemt: "iOS"),
            Employee(name: "Laxman", address: "Hyd", departmemt: "Dev"),
            Employee(name: "santosh", address: "dsnr", departmemt: "iOS")
        ]
        
        let groupByDepart = Dictionary(grouping: emplyees) { (emp) -> String in
            return emp.departmemt
        }
        print("-----By Department----------")
        print(groupByDepart)
        
        let groupByAddress = Dictionary(grouping: emplyees) { (emp) -> String in
            return emp.address
        }
        print("-----By Address----------")
        print(groupByAddress)
        
        let groupByBoth = Dictionary(grouping: emplyees) { (emp) -> String in
            return (emp.address) + (emp.departmemt)
        }
        print("-----By Address & Department----------")
        print(groupByBoth)
        let groupedKeys = groupByBoth.keys.sorted()
        print(groupedKeys)
        
        groupedKeys.forEach { (key) in
            print(groupByBoth[key]!)
        }
    }
    
    
    
    func setupTextView(){
        self.view.addSubview(textView)
        textView.frame = (CGRect(x: 0, y: 0, width: 100, height: 100))
        textView.backgroundColor = .gray
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        textView.isScrollEnabled = false
        textView.delegate = self
        
        textView.text = " This is sample text to check textview dynamic height based on text content."
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        [textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         textView.heightAnchor.constraint(equalToConstant: 50)
            ].forEach{$0.isActive = true}
        textViewDidChange(textView)
        
    }
}

extension ViewController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedHeight = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedHeight.height
            }
        }
    }
    
}

