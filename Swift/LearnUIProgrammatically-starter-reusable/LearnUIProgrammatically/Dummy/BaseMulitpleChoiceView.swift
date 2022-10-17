//
//  TableViewController.swift
//  SandwichApp
//
//  Created by Hilmy Veradin on 06/10/22.
//

import Foundation
import UIKit
import SnapKit

final class BaseMulitpleChoiceView: UIView {
    
    // These strings will be the data for the table view cells
    // MARK: - PROPERTIES
    // MARK: UI
    private lazy var multipleChoiceTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: DATA
    private let cellReuseIdentifier = "cell"
    
    private var textArray: [String]!
    private var cellSpacing: CGFloat!
    
    //MARK: - INITIALIZATION
    init(textArray: [String], cellSpacing: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.textArray = textArray
        self.cellSpacing = cellSpacing
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE
    private func setupView() {
        self.addSubview(multipleChoiceTableView)
        multipleChoiceTableView.snp.makeConstraints { make in
            make.right.top.bottom.left.equalToSuperview()
        }
    }
}

//MARK: - TABLEVIEW EXTENSION
extension BaseMulitpleChoiceView: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table View delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.textArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacing
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.multipleChoiceTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        // note that indexPath.section is used rather than indexPath.row
        cell.textLabel?.text = self.textArray[indexPath.section]
        
        // add border and color
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.section).")
    }
}
