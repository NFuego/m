import ListKit
import UIKit
import SnapKit

struct OrigamiInfo {
    let name:String
    let imgName:String
}

class CategoryOrigamiCell: UITableViewCell, ListKitCellProtocol {
    let overlay:UIView
    let imgView:UIImageView

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        overlay = UIView()
        overlay.backgroundColor = UIColor.white.withAlphaComponent(0.3)

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
            
            self.textLabel!.text = model?.name as String?
            self.textLabel!.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
                make.centerY.equalToSuperview()
            }

            self.contentView.addSubview(overlay)
            self.overlay.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
            }
        }
    }
}

class CategoryOrigamiList : UIViewController {
    var list:UITableView!
    var dataSource : ArrayDataSource<CategoryOrigamiCell,OrigamiInfo>?

    override func viewDidLoad() {
       list = UITableView()
       list.delegate = self
       self.view.addSubview(list)
       list.snp.makeConstraints { (make) in
           make.size.equalToSuperview()
       }

        let infos = [OrigamiInfo(name: "Test", imgName: "origami_time_bg")]
        dataSource = ArrayDataSource(array:infos,cellType:CategoryOrigamiCell.self)
        self.list.dataSource = dataSource
    } // fin viewDidload
}

extension CategoryOrigamiList : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
