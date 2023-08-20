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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueLearningView.layer.cornerRadius = 30
        continueLearningView.layer.masksToBounds = true
        startQuizView.layer.cornerRadius = 30
        startQuizView.layer.masksToBounds = true
    }


    @IBOutlet var continueLearningView: UIView!
 
    
    @IBAction func startQuizTapped(_ sender: UIButton) {
        
        
        let videoVC = storyboard?.instantiateViewController(identifier: "videoQuiz") as! VideoQuizVC

        let imagesVC = storyboard?.instantiateViewController(withIdentifier: "imageQuiz") as! QuizVC

        if categoryName == "في المستشفى" {
            navigationController?.pushViewController(imagesVC, animated: true)
        } else {
            navigationController?.pushViewController(videoVC, animated: true)
            videoVC.categoryName = categoryName
        }
    }
    @IBOutlet var startQuizView: UIView!
    
    @IBAction func lessonsBtnTapped(_ sender: Any) {
        
        let videoVC = storyboard?.instantiateViewController(identifier: "videos") as! VideoLessonsVC
        
        let imagesVC = storyboard?.instantiateViewController(withIdentifier: "lessons") as! LessonsVC
        
        if categoryName == "في المستشفى" {
            navigationController?.pushViewController(imagesVC, animated: true)
        } else {
            navigationController?.pushViewController(videoVC, animated: true)
            videoVC.categoryName = categoryName
        }
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
