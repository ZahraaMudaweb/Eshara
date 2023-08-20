//
//  preQuizVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 06/08/2023.
//

import UIKit

class preQuizVC: UIViewController {
    
    var categoryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startBtnTapped(_ sender: Any) {
        let videoVC = storyboard?.instantiateViewController(identifier: "videoQuiz") as! VideoQuizVC
        
        let imagesVC = storyboard?.instantiateViewController(withIdentifier: "imageQuiz") as! QuizVC
        
        if categoryName == "في المستشفى" {
            navigationController?.pushViewController(imagesVC, animated: true)
        } else {
            navigationController?.pushViewController(videoVC, animated: true)
            videoVC.categoryName = categoryName
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
}
