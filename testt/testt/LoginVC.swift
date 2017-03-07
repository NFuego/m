

import Foundation

import UIKit
import SnapKit
//import Moya
import RxSwift
import RxCocoa
//import BadgeSwift
//import SwiftyJSON
//import SwiftyUserDefaults

//extension DefaultsKeys {
//    static let accountName = DefaultsKey<String?>("accountName")
//    static let pass = DefaultsKey<String?>("pass")
//}

//class LoginVC : ShenZouVC , ShenZouService , GlobalUI {
class LoginVC : UIViewController {

//    open var userModel:UserModel?

    var lbVer:UILabel!
    var imvMark:UIImageView!
    var tfUser:UITextField!
    var tfPass:UITextField!
    var btnLogin:UIButton!
    var lbClaim:UILabel!

    let dpg = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
//        print("loginVC:")
//        print(userModel)

        bindActs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {

    }
} // fin LoginVC

//https://www.hackingwithswift.com/example-code/uikit/how-to-add-a-bar-button-to-a-navigation-bar

// MARK:- Setup
extension LoginVC {
    
    func setup(){
//        let rightBtnImg = UIImage(named:"101a")
//        let rightBtnImg2 = UIImage(named:"101b")
//        let rightButton: UIBarButtonItem = UIBarButtonItem(image: rightBtnImg, style: UIBarButtonItemStyle.plain, target: self, action: nil)
//        let rightButton2: UIBarButtonItem = UIBarButtonItem(image: rightBtnImg2 , style: UIBarButtonItemStyle.plain, target: self, action: nil)


//        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))

//        let badge = BadgeSwift()
//        badge.text = "2"
//            badge.insets = CGSize(width: 12, height: 12)
//        // Text color
//        badge.textColor = UIColor.yellow
//
//        // Badge color
//        badge.badgeColor = UIColor.black
//
//        // Shadow
//        badge.shadowOpacityBadge = 0.5
//        badge.shadowOffsetBadge = CGSize(width: 0, height: 0)
//        badge.shadowRadiusBadge = 1.0
//        badge.shadowColorBadge = UIColor.black
//
//        // No shadow
//        badge.shadowOpacityBadge = 0
//
//        // Border width and color
//        badge.borderWidth = 5.0
//        badge.borderColor = UIColor.magenta
//



        var b = NavBarBtn(frame: CGRect(x: 0, y: 0, width: 35, height: 35))

        b.badgeCount = 1
        b.setTitle("Play", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.setTitleColor(.yellow, for: .highlighted)
        let play = UIBarButtonItem(customView: b)
//        b.addSubview(badge)
//        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: nil)
        let play2 = UIBarButtonItem(title: "Play2", style: .plain, target: self, action: nil)

//        play.customView?.addSubview(badge)
//        navigationItem.rightBarButtonItem = rightButton

//        navigationItem.rightBarButtonItems = [rightButton,rightButton2]
        navigationItem.rightBarButtonItems = [play,play2]

        self.view.backgroundColor = .white

        let screenRt = UIScreen.main.bounds
        let tfW = screenRt.width * 0.7
        let tfH = 28

        // init ui
        let verNum = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        lbVer = UILabel()
        lbVer.textAlignment = .left
        lbVer.text = "Ver \(verNum!)"
        self.view.addSubview(lbVer)

        imvMark = UIImageView(image: UIImage(named: "zs_mark"))
        self.view.addSubview(imvMark)

        tfUser = UITextField()
        tfUser.adjustsFontSizeToFitWidth = true
        tfUser.borderStyle = .bezel
//        tfUser.placeholder = NSLocalizedString("string.account.placeholder", comment: "")
        tfUser.text = "ios-store@gmail.com"
//        (id: 2) ios-customer@gmail.com
        self.view.addSubview(tfUser)

        tfPass = UITextField()
        tfPass.adjustsFontSizeToFitWidth = true
        tfPass.borderStyle = .bezel
        tfPass.isSecureTextEntry = true
//        tfPass.placeholder = NSLocalizedString("string.pass.placeholder", comment: "")
        tfPass.text = "secret"
        self.view.addSubview(tfPass)

        btnLogin = UIButton()
//        btnLogin.setBackgroundImage(UIImage(color: UIColor.zs_3in1Opt1()) , for: .normal)
//        btnLogin.setBackgroundImage(UIImage(color: UIColor.zs_highlightedColor()), for: .highlighted)
//        btnLogin.setTitle(NSLocalizedString("string.login", comment: ""), for: UIControlState.normal)
//        btnLogin.setTitle(NSLocalizedString("string.login", comment: ""), for: UIControlState.highlighted)
        
        btnLogin.setTitle("登入", for: UIControlState.normal)
        btnLogin.setTitle("登入", for: UIControlState.highlighted)

        btnLogin.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(btnLogin)

        lbClaim = UILabel()
        lbClaim.adjustsFontSizeToFitWidth = true
//        lbClaim.text = NSLocalizedString("string.claim", comment: "")
        lbClaim.text = ""
        lbClaim.textAlignment = .center
        self.view.addSubview(lbClaim)

        // layout
        lbVer.snp.makeConstraints { (make) in
            make.width.equalTo(tfW)
            make.height.equalTo(tfH)
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(10)
        }

        tfUser.snp.makeConstraints { (make) in
            make.width.equalTo(tfW)
            make.height.equalTo(tfH)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-tfH)
        }

        tfPass.snp.makeConstraints { (make) in
            make.width.equalTo(tfW)
            make.height.equalTo(tfH)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(tfH)
        }

        imvMark.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.height.equalTo(112.5)
            make.bottom.equalTo(tfUser.snp.top)
            make.centerX.equalTo(tfUser)
        }

        btnLogin.snp.makeConstraints { (make) in
            make.width.equalTo(tfW)
            make.height.equalTo(tfH)
            make.centerX.equalTo(tfPass)
            make.top.equalTo(tfPass.snp.bottom).offset(tfH)
        }

        lbClaim.snp.makeConstraints { (make) in
            make.height.equalTo(tfH)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }

//        UIHelper.addLeftIconToUIText(target: tfUser, icon: "zs_login_account", rt: CGRect(x: 0, y: tfH/2, width: Int(Double(tfH) * 0.8), height: Int(Double(tfH) * 0.8)))
//        UIHelper.addLeftIconToUIText(target: tfPass, icon: "zs_login_pass", rt: CGRect(x: 0, y: tfH/2, width: Int(Double(tfH) * 0.8), height: Int(Double(tfH) * 0.8)))

        // auto fill the fields if there are data cached previously
//        if Defaults[.accountName] != "" && Defaults[.pass] != "" {
//           tfUser.text = Defaults[.accountName]
//           tfPass.text = Defaults[.pass]
//        }

        // dev use
//        self.login(req:.Auth(name: "006", password: "006006"))
//        self.login(req:.Auth(name: "00wefiowjefoiw", password: "00fewfewf6006"))
//        self.login(req:.Auth(name: "wefiowjefoiw", password: "fewfewf"))
//        self.slideMenuController()?.changeMainViewController(LeftSlideVC.p2VC, close: true)
//                self.slideMenuController()?.changeMainViewController(LeftSlideVC.userDetailVC, close: true)
//                self.slideMenuController()?.changeMainViewController(LeftSlideVC.inOneVC, close: true)
//                self.slideMenuController()?.changeMainViewController(LeftSlideVC.p2VC, close: true)
//                self.slideMenuController()?.changeMainViewController(LeftSlideVC.remoteConsult, close: true)
    } // fin setup
}

// MARK:- Actions
extension LoginVC {
    func bindActs(){
       bindBtnLogin()
    }

    func bindBtnLogin(){
        btnLogin.rx.tap.subscribe(onNext: { [weak self] in
//                print("here1 \(self?.tfUser.text)  \(self?.tfPass.text)")

            self?.dismiss(animated: true, completion: {
                
            })
            

            return 
            if self?.tfUser.text != "" && self?.tfPass.text != "" {
//                print("\(self?.tfUser.text) \(self?.tfPass.text)")
//                self?.playLoadingView()
//                self?.login(req:.Auth(name: (self?.tfUser.text)! , password: (self?.tfPass.text)! ))

            } else {
                // no account or pass
//                self?.showAlert(msg: NSLocalizedString("string.login.alert", comment: ""))
            }
        }).addDisposableTo(dpg)
    } // fin bind BtnLogin

//    func login(req:ShenZouAPI){

//        auth(req:req, { (json:JSON) in
//            self.stopLoadingView()
//
//            let code:Int = (json.dictionary?["error_code"]?.intValue)!
//            switch code {
//            case 999 :
//                let error_msg = json.dictionary?["error_message"]?.stringValue
//                self.showAlert(msg: error_msg!)
//                break
//            case 0 : // success login
//                // cache the login account and its pass
//                Defaults[.accountName] = self.tfUser.text
//                Defaults[.pass] = self.tfPass.text
//
//                 // cache token
//                let res = String.tokenDec(data: (json.dictionary?["result"]?.string)!)
//                if let token = res["token"] as? String {
//                    print("#- Get token from parsed json : ----------------------------")
//                    print(token)
//                    print("#-----------------------------")
//
//                    let userModel = UserModel(token: token)
//                    let u2 = UserModel(data: res)
//                    print(userModel)
//                    print(u2)
//                    if let birthday = res["birthday"] as? String {
//                        userModel.birthday = birthday
//                    }
//                    if let email = res["email"] as? String {
//                        userModel.email = email
//                    }
//                    if let fullName = res["full_name"] {
//                       userModel.fullName = fullName as! String
//                    }
//                    if let mobile = res["mobile"] {
//                        userModel.mobile = mobile as! String
//                    }
//                    if let gender = res["gender"] {
//                        userModel.gender = gender as! String
//                    }
//                    if let date = res["date"] {
//                        userModel.date = date as! String
//                    }
//                    if let userName = res["username"] {
//                       userModel.userName = userName as! String
//                    }
//                    if let height = res["height"] {
////                        userModel.height = String(describing:height).toInt()
//                        userModel.height = height as! String
//                    }
//                    if let unit = res["unit"] {
//                        userModel.unit = unit as! String
//                    }
//                    if let weight = res["weight"] {
//                        userModel.weight = weight as! String
//                    }
//
//                    userModel.pass = self.tfPass.text!
//                    self.userDataProvider.setData(userModel)
//                    ShenZouApp.modelsMgr.ins.user = userModel
//                }
//
//                // show the page
//                self.slideMenuController()?.changeMainViewController(LeftSlideVC.inOneVC, close: true)
//
//                break
//            default:
//
//                break
//            }
//                // show UI
//        }).addDisposableTo(dpg)
//    } // fin login
}
