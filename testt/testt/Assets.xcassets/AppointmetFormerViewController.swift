// MARK: Imports

import UIKit

import Eureka
import SwiftyVIPER
import Kingfisher
import SnapKit

// MARK: Protocols

/// Should be conformed to by the `AppointmetFormerInteractor` and referenced by `AppointmetFormerPresenter`
protocol AppointmetFormerPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the AppointmetFormer module
class AppointmetFormerViewController: FormViewController {

	// MARK: - Constants
	let presenter: AppointmetFormerViewPresenterProtocol

	// MARK: Variables
    let lbColor = UIColor.black

	// MARK: Inits
	init(presenter: AppointmetFormerViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()
		view.backgroundColor = .white
        self.setupForm()
    }
}


// MARK: - AppointmetFormer Presenter to View Protocol
extension AppointmetFormerViewController: AppointmetFormerPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}


extension AppointmetFormerViewController {
    func setupForm(){
        let header = "Appoint"

        /*
         loaded :


         icon
         name
         class
         weight
         age

         
         descript:
         owner name
         email
         phone
         address
 */
//         icon
//         name
//         class
//         weight
//         age
//
//
//         descript:
//         owner name
//         email 
//         phone
//         address

            form  +++ Section(header: header, footer: "")          //bleConnMsg)
                <<< ImgRow() { (i:ImgRow) -> Void in
                    i.value = Picture(url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVKqyeR1MompJT0wpeE_24HEIF-DlXAkyz69a_qTYxhxf_GVXneA")
                    
                }
                <<< LabelRow() { (l:LabelRow) -> Void in
                    l.title = "hihi"
                    
                } .onCellSelection({ (cell, label) in
                    
                })
                <<< NameRow() { (row:NameRow) -> Void in
                    row.title = "petname" //NSLocalizedString("blevc-scan", comment: "")
                    row.cell.tintColor = .green
                    row.cell.textLabel?.text =  "fwfjwoiejfoiwe"
                } .onCellSelection({ (cell, row) in
                    // here to scan
                    print(cell)
    //                self.bluetoothManager.stopScan()
    //                self.bluetoothManager.startScan()
                }) <<< TextRow() { (row2:TextRow) -> Void in
                    row2.title = "text" //NSLocalizedString("blevc-scan", comment: "")
                    row2.cell.tintColor = .green
                    row2.cell.textField.isEnabled = false
                    row2.cell.textField.text = "fwfjoweijfowijfojweio"
//                    row2.disabled = true
                    
                    } .onCellSelection( { (cell, row) in
                    print("text selection")
                        }
                        
                    ).onChange({ (row:TextRow) in
                })
//                +++ bleListSec
    } // fin setupForm
}

// ===================================================================================  new row & cell

struct Picture: Equatable {
    var url: String?
}
//
func ==(lhs: Picture, rhs: Picture) -> Bool {
    return lhs.url == rhs.url
}



final class ImgCell : Cell<Picture>,CellType {

    let img:UIImageView = UIImageView()
    let imgSize = 100
    let processor = RoundCornerImageProcessor(cornerRadius: 50)

    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(img)
        self.img.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(imgSize)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setup() {
        super.setup()
        selectionStyle = .none
        height = { return 120 }
    }


    override func update() {
        guard let pic = row.value else { return }
        if let url = pic.url {
            self.img.kf.setImage(with: URL(string:url), options: [.transition(.fade(0.2)), .processor(processor)])
            self.img.kf.indicatorType = .activity
        }
    }
}

final class ImgRow : Row<ImgCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<ImgCell>()
    }
}
