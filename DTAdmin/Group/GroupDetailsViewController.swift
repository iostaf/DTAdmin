//
//  GroupDetailsViewController.swift
//  DTAdmin
//
//  Created by Admin on 29.10.17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class GroupDetailsViewController: UIViewController {
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var facultyNameLabel: UILabel!
    
    @IBOutlet weak var facultyDescriptionLabel: UILabel!
    
    @IBOutlet weak var specialityNameLabel: UILabel!
    
    @IBOutlet weak var specialityCodeLabel: UILabel!
    
    @IBAction func getStudentsByGroupTapped(_ sender: Any) {
        let studentStoryboard = UIStoryboard.stoyboard(by: .student)
        guard let studentViewControler = studentStoryboard.instantiateViewController(withIdentifier: "StudentViewController") as? StudentViewController, let group = group else { return }
        studentViewControler.selectedGroup = group
        self.navigationController?.pushViewController(studentViewControler, animated: true)    }
    @IBAction func getTimeTableByGroupTapped(_ sender: Any) {
    }
    @IBAction func getResultsByGroupTapped(_ sender: Any) {
    }
    
    var group: GroupStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Details", comment: "Title for Group Detail view")
        getDetailsByGroup()
    }
    
    func getDetailsByGroup() {
        guard let group = group else { return }
        self.groupNameLabel.text = group.groupName
        DataManager.shared.getEntity(byId: group.facultyId, typeEntity: .faculty){
            (faculty, error) in
            if let error = error {
                self.showWarningMsg(error.info)
            } else {
                guard let faculty = faculty as? FacultyStructure else { return }
                DispatchQueue.main.async {
                    self.facultyNameLabel.text = faculty.name
                    self.facultyDescriptionLabel.text = faculty.description
                }
            }
        }
        DataManager.shared.getEntity(byId: group.specialityId, typeEntity: .speciality){
            (speciality, error) in
            if let error = error {
                self.showWarningMsg(error.info)
            } else {
                guard let speciality = speciality as? SpecialityStructure else { return }
                DispatchQueue.main.async {
                    self.specialityNameLabel.text = speciality.name
                    self.specialityCodeLabel.text = speciality.code
                }
            }
        }
    }
}
