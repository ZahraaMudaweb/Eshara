//
//  StagesVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 03/08/2023.
//

import UIKit
import FirebaseStorage

class StagesVC: UIViewController {

    
    var categoryName : String?
    
    var itemIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        continueLearningView.layer.cornerRadius = 30
        continueLearningView.layer.masksToBounds = true
        startQuizView.layer.cornerRadius = 30
        startQuizView.layer.masksToBounds = true
    }


    @IBOutlet var continueLearningView: UIView!
 
    
    @IBAction func startQuizTapped(_ sender: UIButton) {
        
        let preVC = storyboard?.instantiateViewController(withIdentifier: "preQuiz") as! preQuizVC
        preVC.categoryName = categoryName
        preVC.itemIndex = itemIndex
        navigationController?.pushViewController(preVC, animated: true)
    }
    @IBOutlet var startQuizView: UIView!
    
    @IBAction func lessonsBtnTapped(_ sender: Any) {
        
        let videoVC = storyboard?.instantiateViewController(identifier: "videos") as! VideoLessonsVC
        
        let imagesVC = storyboard?.instantiateViewController(withIdentifier: "lessons") as! LessonsVC
        
        let preVC = storyboard?.instantiateViewController(withIdentifier: "preQuiz") as! preQuizVC
        
        preVC.categoryName = categoryName
        preVC.itemIndex = itemIndex
        
        if categoryName == "في المستشفى" {
            imagesVC.categoryName = "في المستشفى"
            navigationController?.pushViewController(imagesVC, animated: true)
        } else {
            navigationController?.pushViewController(videoVC, animated: true)
            videoVC.categoryName = categoryName
            videoVC.itemIndex = itemIndex
        }
    }
    @IBAction func unwindToStages(_ segue: UIStoryboardSegue) {
        // decrease hearts by 1
        
        // show an alert
//        let alertController = UIAlertController(title: "تنبيه!", message: "ستفقد إحدى محاولاتك بالعودة للصفحة السابقة", preferredStyle: .alert)
//        let action = UIAlertAction(title: "موافق", style: .default)
//        let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel)
//        alertController.addAction(action)
//        alertController.addAction(cancelAction)
//        present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
