//
//  DataModel.swift
//  DTAdmin
//
//  Created by Volodymyr on 11/12/17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    static let dataModel = DataModel()
    var testDetailArray = [TestDetailStructure]()
    var levelArrayForFiltering = [Int]()
    var taskArrayForFiltering = [Int]()
    var testDetails = ["level", "task", "rate"]
    let max = 10
    
    func createArray(max: Int) -> [Int] {
        var array = [Int]()
        for i in 1...max {
            array.append(i)
        }
        return array
    }
    
    func getFilteredArrayForLevels(firstArray: [Int], secondArray: [Int]) -> [Int] {
        var filtered = firstArray
        for item in secondArray {
            if let index = filtered.index(of: item) {
                filtered.remove(at: index)
            }
        }
        return filtered
    }

    
}
