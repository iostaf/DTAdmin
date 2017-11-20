//
//  ViewController.swift
//  DTAdmin
//
//  Created by ITA student on 10/10/17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        var tabBarViewControllers = [UIViewController]()
        
//MARK: Create students tab
        let studentStoryboard = UIStoryboard(name: "Student", bundle: nil)
        guard let studentNavigationController = studentStoryboard.instantiateViewController(withIdentifier: "StudentNavigationController") as? UINavigationController else { return }
        let titleText = NSLocalizedString("Students", comment: "List all students")
        let studentBarItem = UITabBarItem(title: titleText, image: nil, selectedImage: nil)
        studentBarItem.image = UIImage(named: "ic_person_outline_white")
        studentNavigationController.tabBarItem = studentBarItem
        tabBarViewControllers.append(studentNavigationController)

//MARK: Create subjects tab
        let subjectStoryboard = UIStoryboard.stoyboard(by: .subject)
        guard let subjectNavController = subjectStoryboard.instantiateViewController(withIdentifier: "SubjectNavController") as? UINavigationController else { return }
        let subjectBarItem = UITabBarItem(title: "Subjects", image: nil, selectedImage: nil)
        subjectBarItem.image = UIImage(named: "ic_subject_white")
        subjectNavController.tabBarItem = subjectBarItem
        tabBarViewControllers.append(subjectNavController)

//MARK: Create groups tab
        let groupStoryboard = UIStoryboard.stoyboard(by: .group)
        guard let groupNavController = groupStoryboard.instantiateViewController(withIdentifier: "GroupNavController") as? UINavigationController else { return }
        let groupsBarItem = UITabBarItem(title: "Groups", image: nil, selectedImage: nil)
        groupsBarItem.image = UIImage(named: "ic_supervisor_account_white")
        groupNavController.tabBarItem = groupsBarItem
        tabBarViewControllers.append(groupNavController)
        
// Create faculty tab
        let facultyTab = TabFourViewController()
        let facultyBarItem = UITabBarItem(title: "Faculty", image: nil, selectedImage: nil)
        facultyBarItem.image = UIImage(named: "ic_account_balance_white")
        facultyTab.tabBarItem = facultyBarItem
        tabBarViewControllers.append(facultyTab)

// Create speciality tab
        let specialityTab = UIStoryboard.stoyboard(by: .speciality)
        guard let specialityNavController = specialityTab.instantiateViewController(withIdentifier: "SpecialityNavController") as? UINavigationController else { return }
        let specialityBarItem = UITabBarItem(title: "Speciality", image: nil, selectedImage: nil)
//        specialityBarItem.image = UIImage(named: "")
        specialityNavController.tabBarItem = specialityBarItem
        tabBarViewControllers.append(specialityNavController)
        
//MARK: Create admins tab
        let adminStoryboard = UIStoryboard.stoyboard(by: .admin)
        guard let adminsNavController = adminStoryboard.instantiateViewController(withIdentifier: "AdminListView") as? UINavigationController else { return }
        let adminsBarItem = UITabBarItem(title: "Admins", image: nil, selectedImage: nil)
        adminsBarItem.image = UIImage(named: "ic_subject_white")
        adminsNavController.tabBarItem = adminsBarItem
        tabBarViewControllers.append(adminsNavController)
        

//MARK: Create timeTable tab
        guard let logoutController = self.storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") as? LogoutViewController else { return }
        let logoutBarItem = UITabBarItem(title: "Logout", image: nil, selectedImage: nil)
        logoutBarItem.image = UIImage(named: "ic_exit_to_app_white")
        logoutController.tabBarItem = logoutBarItem
        tabBarViewControllers.append(logoutController)

        self.setViewControllers(tabBarViewControllers, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//MARK: UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let title = viewController.title {
            print("Selected \(title)")
        }
        if let navTitle = (viewController as? UINavigationController)?.viewControllers.first?.title {
            print("Selected \(navTitle)")
        }
    }
}

//MARK: temp view controllers for test
class TabOneViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.title = "Students"
    }
}

class TabThreeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.title = "Groups"
    }
}

class TabFourViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.title = "Faculty"
    }
}

class TabFiveViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.title = "Speciality"
    }
}

