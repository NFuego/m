
import UIKit
import Alamofire
import SwiftyJSON
import SnapKit

class ViewController: UIViewController {

    let lbCommitMsg = UILabel()
    var imw:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .cyan
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navBar"), for: .default)

//        self.extendedLayoutIncludesOpaqueBars = []
        let title = NSLocalizedString("origami", comment: "")
        self.title = "Origami Time ver. 1.0"
        self.setupFramePhoto()
//        setupBg()
        commitAsMessage()
        authorWords()
    }

    func setupBg(){
        let imw = UIImageView(image: UIImage(named:"origami_time_bg"))
        self.view.addSubview(imw)
        imw.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }

    func setupFramePhoto(){
        imw = UIImageView(image: UIImage(named:"origami_time_bg"))
        self.view.addSubview(imw)
//        let degrees:CGFloat = 10
//        imw.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        imw.snp.makeConstraints { (make) in
//            make.equalToSuperview()
//            make.equalToSuperview()

            make.size.width.equalTo(472 * 0.6)
            make.size.height.equalTo(709 * 0.6)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
//        imw.transform = CGAffineTransform(rotationAngle: degrees * CGFloat(M_PI/180) )

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
            self.lbCommitMsg.textAlignment = .center

            self.view.addSubview(self.lbCommitMsg)
            let attrStr = try! NSAttributedString(
                data: msg.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            self.lbCommitMsg.attributedText = attrStr
            self.lbCommitMsg.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(10)
                make.width.equalToSuperview()
                make.height.equalTo(70)
            })
//            let str = "<p style=\"color:#FFFFFF;font-size:38px\">Thanks your donwload.</p>"
        }
    }

    func authorWords(){
        let t = UITextView()
//        let t = UILabel()
        t.textColor = .black
//        t.textAlignment = .center
//        t.numberOfLines = 5
        t.textAlignment = .center
        t.text = "I think Origami is a very elegant art, \n You could concentrate when you are folding., \ni hope Origami Time could bring you\n a wonderful time.ii"
        // blur
//        let be = UIBlurEffect(style: .extraLight)
//        let v = UIVisualEffectView(effect: be)
//
//        v.backgroundColor = UIColor.white.withAlphaComponent(0.2)
//        v.clipsToBounds = true
//        v.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
//        v.layer.borderWidth = 1.0
//        v.layer.cornerRadius = 6.0
        
//        t.textColor = UIColor.black.withAlphaComponent(0.3)
//        t.sizeToFit()
//        v.addSubview(t)
        self.view.addSubview(t)
        t.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(90)
//            make.bottom.equalToSuperview().offset(-50)
//            make.top.equalTo(t.snp.bottom).offset(100)
            make.bottom.equalTo(imw.snp.top).offset(-30)
            make.centerX.equalToSuperview()
        }
        
//
//        // label
//        UILabel *label = [[UILabel alloc] init];
//        label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
//        [label sizeToFit];
//        
//        // add the label to effect view
//        [blurView.contentView addSubview:label];
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
