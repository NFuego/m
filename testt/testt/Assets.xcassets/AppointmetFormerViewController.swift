//  AppointmetFormerViewController.swift
//  Project: testt
//
//  Module: AppointmetFormer
//
//  By zcon 2017/3/9
//  test 2017年
//

// MARK: Imports

import UIKit

import Eureka
import SwiftyVIPER

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
        
            form  +++ Section(header: header, footer: "")          //bleConnMsg)
                <<< NameRow() { (row:NameRow) -> Void in
                    row.title = "name" //NSLocalizedString("blevc-scan", comment: "")
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
                <<< LabelRow() { (r:LabelRow) -> Void in
                    r.title = "hihi"
                    
                } .onCellSelection({ (cell, label) in
                    
                })
//                +++ bleListSec
    } // fin setupForm
}
