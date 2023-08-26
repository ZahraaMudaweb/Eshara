//
//  TeachersData.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import Foundation
import UIKit



struct Teacherdata
{
    var teacherName: String
    var teacherRate: Double
    var teacherLocation: String
    var teacherPrice: Double
    var tecaherImage: UIImage?
    var color: UIColor
}

struct StudentReviews
{
    var StudentName: String
    var StudentRate: Double
    var StudetComment: String
    var studentIMage: UIImage?
}

struct AddStudentrevie
{
    var studentRate: String
    var StudentCommrnt: String
    var studentname: String
    var studentIMage: UIImage?
}
struct BookMarkDate
{
    var date: String
    var Rate: String
    var image: UIImage?
    
    
    
    init(date: String, Rate: String) {
        self.date = date
        self.Rate = Rate
    }
    
    func dictionaryReviews() -> [String: Any]
    {
        var dict: [String: Any] = [:]
        dict["Reviews"] = date
        dict["Rate"] = Rate
        return dict
    }
    
   
}

