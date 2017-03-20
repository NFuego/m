
import UIKit
import Alamofire
import SwiftyJSON
import SnapKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .blue
//        self.edgesForExtendedLayout = []
//        self.extendedLayoutIncludesOpaqueBars = []
        self.navigationController?.navigationBar.isTranslucent = true
        let title = NSLocalizedString("origami", comment: "")
        self.title = title
        setupBg()
        commitAsMessage()
    }

    func setupBg(){
        let imw = UIImageView(image: UIImage(named:"origami_time_bg"))
        self.view.addSubview(imw)
        imw.snp.makeConstraints { (make) in
//            make.equalToSuperview()
//            make.equalToSuperview()
            make.size.equalToSuperview()
        }
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
            t.textAlignment = .center

            self.view.addSubview(t)
            let attrStr = try! NSAttributedString(
                data: msg.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            t.attributedText = attrStr
            t.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(10)
                make.width.equalToSuperview()
                make.height.equalTo(70)
            })
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

