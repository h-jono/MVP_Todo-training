//
//  TodoListViewController.swift
//  MVP_Todo-Training
//
//  Created by 城野 on 2021/03/25.
//

import Foundation
import UIKit

final class TodoListViewController: UIViewController {
    
    private var presenter: TodoListPresenterInput!
    func inject (presenter: TodoListPresenterInput) {
        self.presenter = presenter
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var newItemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter.viewDidLoad()
    }
    
    @IBAction func tappedAddButton() {
        if !newItemTextField.text!.isEmpty {
            presenter.addNewItem(itemContent: newItemTextField.text!)
            newItemTextField.text = ""
            newItemTextField.resignFirstResponder()
        }
    }
}
extension TodoListViewController: TodoListPresenterOutput {
    func updateItems() {
        tableView.reloadData()
    }
}
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = presenter.item(forRow: indexPath.row)
        
        return cell
    }
}
extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.didEditingDelete(at: indexPath)
        }
    }
}
extension TodoListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
