//  ViewController.swift
//  testt
//
//  Created by zcon on 2017/3/7.
//  Copyright © 2017年 test. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        commitAsMessage()

        
    }


    func commitAsMessage(){
         let url = "https://api.github.com/repos/NFuego/m/commits"
        Alamofire.request(url).response { response in
//            print("Request: \(response.request)")
//            print("Response: \(response.response)")
//            print("Error: \(response.error)")
//            print(JSON(data:response.data!))
//                let json = JSON(data:response.data!)

            var msg = ""
            if let data = response.data {
                let json = JSON(data:data)
                msg = (json.array?.first?.dictionary?["commit"]!["message"].stringValue)!
                print(msg)
            }// Do any additional setup after loading the view, typically from a nib.
            let t = UILabel()
            t.frame = self.view.frame
            self.view.addSubview(t)
            var attrStr = try! NSAttributedString(
                data: msg.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            t.attributedText = attrStr
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

