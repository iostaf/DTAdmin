
//
//  SpecialityViewController.swift
//  DTAdmin
//
//  Created by Volodymyr on 11/1/17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class SpecialitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var specialitiesArray = [SpecialityStructure]()
    var filteredSpecialitiesArray = [SpecialityStructure]()
    lazy var refresh: UIRefreshControl = UIRefreshControl()
    @IBOutlet weak var specialitiesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var getSpeciality = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString(Entities.speciality.rawValue, comment: "All specialities")
        refresh.addTarget(self, action: #selector(refreshDataInTableView), for: .valueChanged)
        specialitiesTableView.refreshControl = refresh
        refreshDataInTableView()
        searchBar.delegate = self
    }
    
    @objc func refreshDataInTableView() {
        refresh.beginRefreshing()
        DataManager.shared.getList(byEntity: .speciality) { (speciality, error) in
            if error == nil, let specialityies = speciality as? [SpecialityStructure] {
                self.specialitiesArray = specialityies
                self.filteredSpecialitiesArray = self.specialitiesArray
                self.specialitiesTableView.reloadData()
            } else {
                self.showWarningMsg(error ?? NSLocalizedString("Incorect type data", comment: "Incorect type data"))
            }
            
        }
        self.refresh.endRefreshing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredSpecialitiesArray = specialitiesArray
            specialitiesTableView.reloadData()
            return
        }
        filteredSpecialitiesArray = specialitiesArray.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        specialitiesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        let id = UILabel()
        id.text = "id"
        id.textColor = UIColor.white
        id.frame = CGRect(x: 10, y: 2, width: 20, height: 25)
        view.addSubview(id)
        let code = UILabel()
        code.text = "code"
        code.textColor = UIColor.white
        code.frame = CGRect(x: 40, y: 2, width: 40, height: 25)
        view.addSubview(code)
        let name = UILabel()
        name.text = "speciality"
        name.textColor = UIColor.white
        name.frame = CGRect(x: 170, y: 2, width: 120, height: 25)
        view.addSubview(name)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSpecialitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prototypeCell = tableView.dequeueReusableCell(withIdentifier: "specialityCell",
                                                          for: indexPath) as? SpecialityTableViewCell
        guard let cell = prototypeCell else { return UITableViewCell() }
        let array = filteredSpecialitiesArray[indexPath.row]
        cell.specialityIdLabel.text = array.id
        cell.specialityCodeLabel.text = array.code
        cell.specialityNameLabel.text = array.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit", handler: { action, indexPath in
            guard let specialityCreateUpdateViewController = UIStoryboard(name: "Speciality",
            bundle: nil).instantiateViewController(withIdentifier: "SpecialityCreateUpdateViewController")
            as? SpecialityCreateUpdateViewController else { return }
            specialityCreateUpdateViewController.specialityInstance = self.filteredSpecialitiesArray[indexPath.row]
            specialityCreateUpdateViewController.canEdit = true
            specialityCreateUpdateViewController.resultModification = { updateResult in
                self.filteredSpecialitiesArray[indexPath.row] = updateResult
                self.specialitiesTableView.reloadData()
            }
            self.navigationController?.pushViewController(specialityCreateUpdateViewController, animated: true)
        })
        let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, indexPath in
            let alert = UIAlertController(title: "WARNING",
                                          message: "Do you want to delete this speciality?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                guard let id = self.filteredSpecialitiesArray[indexPath.row].id else { return }
                if indexPath.row < self.filteredSpecialitiesArray.count {
                    DataManager.shared.deleteEntity(byId: id, typeEntity: .speciality) { (deleted, error) in
                        if let error = error {
                            self.showWarningMsg(error)
                        } else {
                            self.filteredSpecialitiesArray.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .top)
                            self.specialitiesTableView.reloadData()
                        }
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        })
        return [edit, delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if getSpeciality {
            print("true")
            self.navigationController?.popViewController(animated: true)
        } else {
            guard let specialityInfoViewController = UIStoryboard(name: "Speciality",
            bundle: nil).instantiateViewController(withIdentifier: "SpecialityInfoViewController")
            as? SpecialityInfoViewController else  { return }
            specialityInfoViewController.specialityInstance = self.filteredSpecialitiesArray[indexPath.row]
            self.navigationController?.pushViewController(specialityInfoViewController, animated: true)
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let specialityCreateUpdateViewController = UIStoryboard(name: "Speciality",
        bundle: nil).instantiateViewController(withIdentifier: "SpecialityCreateUpdateViewController")
        as? SpecialityCreateUpdateViewController else { return }
        self.navigationController?.pushViewController(specialityCreateUpdateViewController, animated: true)
        specialityCreateUpdateViewController.resultModification = { newSpeciality in
            self.filteredSpecialitiesArray.append(newSpeciality)
            self.specialitiesTableView.reloadData()
        }
    }
    
    /* - - - LogIn for testing - - - */
    @IBAction func loginButtonTapped(_ sender: Any) {
        //test data
        let loginText = "admin"
        let passwordText = "dtapi_admin"
        
        CommonNetworkManager.shared().logIn(username: loginText, password: passwordText) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                StoreHelper.saveUser(user: user)
                DispatchQueue.main.async {
                    print("user is logged")
                }
            }
        }
        
    }
    
    
}


