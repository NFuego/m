import ListKit
import UIKit
import SnapKit

/*
https://www.amazon.com/120-Writing-Summaries-Q91-120-Pack/dp/1499605625
 */

struct OrigamiInfo {
    let name:String
    let imgName:String
}

class CategoryOrigamiCell: UITableViewCell, ListKitCellProtocol {
    let overlay:UIView
    let imgView:UIImageView

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        imgView = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: OrigamiInfo? {
        didSet {
            let img = UIImage(named: (model?.imgName)!)
            imgView.image = img
            self.contentView.addSubview(imgView)
            
            self.imgView.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
            }

            self.contentView.addSubview(overlay)
            self.overlay.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
            }

            self.overlay.addSubview(self.textLabel!)
            self.textLabel!.text = model?.name as String?
            self.textLabel!.font = UIFont.systemFont(ofSize: 25)
            self.textLabel!.textColor = .white
            self.textLabel!.textAlignment = .center
            self.textLabel!.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
    } // fin model
}

class CategoryOrigamiList : UIViewController {
    var list:UITableView!
    var dataSource : ArrayDataSource<CategoryOrigamiCell,OrigamiInfo>?

    override func viewDidLoad() {
        let title = NSLocalizedString("title", comment: "")
        self.title = title

       list = UITableView()
        list.backgroundColor = .white
       list.delegate = self
       self.view.addSubview(list)
       list.snp.makeConstraints { (make) in
           make.size.equalToSuperview()
       }

        let infos = [OrigamiInfo(name:"Test", imgName:"origami_time_bg"),
                     OrigamiInfo(name:"test2",imgName:"origami_time_bg"),
                     OrigamiInfo(name:"test2",imgName:"origami_time_bg"),
                     OrigamiInfo(name:"test2",imgName:"origami_time_bg"),
                     OrigamiInfo(name:"test2",imgName:"origami_time_bg"),
                     OrigamiInfo(name:"test2",imgName:"origami_time_bg"),
                     OrigamiInfo(name:"test2",imgName:"origami_time_bg")
        ]
        dataSource = ArrayDataSource(array:infos,cellType:CategoryOrigamiCell.self)
        self.list.dataSource = dataSource
    } // fin viewDidload
}

extension CategoryOrigamiList : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.5
        
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        self.navigationController?.view.layer.add(transition, forKey: nil)

        let u = UIViewController()
        self.navigationController?.pushViewController(u, animated: false)
    }
}
