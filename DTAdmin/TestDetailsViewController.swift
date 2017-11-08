//
//  TestDetailsViewController.swift
//  DTAdmin
//
//  Created by ITA student on 11/6/17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class TestDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var testDetailArray = [TestDetailStructure]()
    var id = "1"
    @IBOutlet weak var testDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataManager.shared.getTestDetails(byTest: id) { (details, error) in
            if error == nil, let testDetails = details as? [TestDetailStructure] {
                self.testDetailArray = testDetails
                self.testDetailsTableView.reloadData()
            } else {
                self.showWarningMsg(error ?? NSLocalizedString("Incorect type data", comment: "Incorect type data"))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prototypeCell = tableView.dequeueReusableCell(withIdentifier: "testDetailsCell", for: indexPath) as? TestDetailsTableViewCell
        guard let cell = prototypeCell else { return UITableViewCell() }
        let array = testDetailArray[indexPath.row]
        cell.testDetailId.text = array.id
        cell.testDetailTestId.text = array.testId
        cell.testDetailLevel.text = array.level
        cell.testDetailTasks.text = array.tasks
        cell.testDetailRate.text = array.rate
        return cell
    }
    
    /* - - - edit && delete - - -  */
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        <#code#>
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let edit = UITableViewRowAction(style: .normal, title: "Edit", handler: { action, indexPath in
//            guard let specialityCreateUpdateViewController = UIStoryboard(name: "Speciality", bundle: nil).instantiateViewController(withIdentifier: "SpecialityCreateUpdateViewController") as? SpecialityCreateUpdateViewController else  { return }
//            specialityCreateUpdateViewController.specialityInstance = self.specialitiesArray[indexPath.row]
//            specialityCreateUpdateViewController.canEdit = true
//            specialityCreateUpdateViewController.resultModification = { updateResult in
//                self.specialitiesArray[indexPath.row] = updateResult
//                self.specialitiesTableView.reloadData()
//            }
//            self.navigationController?.pushViewController(specialityCreateUpdateViewController, animated: true)
//        })
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, indexPath in
//            let alert = UIAlertController(title: "WARNING", message: "Do you want to delete this speciality?", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action) in
//                alert.dismiss(animated: true, completion: nil)
//                guard let id = self.specialitiesArray[indexPath.row].id else { return }
//                if indexPath.row < self.filteredSpecialitiesArray.count {
//                    DataManager.shared.deleteEntity(byId: id, typeEntity: Entities.Speciality) { (deleted, error) in
//                        if let error = error {
//                            self.showWarningMsg(error)
//                        } else {
//                            self.filteredSpecialitiesArray.remove(at: indexPath.row)
//                            tableView.deleteRows(at: [indexPath], with: .top)
//                            self.specialitiesTableView.reloadData()
//                        }
//                    }
//                }
//            }))
//            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (action) in
//                alert.dismiss(animated: true, completion: nil)
//            }))
//            self.present(alert, animated: true, completion: nil)
//        })
//        return [edit, delete]
//    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let testDetailCreateUpdateViewController = UIStoryboard(name: "TestDetails", bundle: nil).instantiateViewController(withIdentifier: "TestDetailCreateUpdateViewController") as? TestDetailCreateUpdateViewController else { return }
        self.navigationController?.pushViewController(testDetailCreateUpdateViewController, animated: true)
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
