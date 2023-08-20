//
//  ResultsVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 15/08/2023.
//

import UIKit

class ResultsVC: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var encourageLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var heartsLabel: UILabel!
   
    var score: Int?
    var hearts: Int?
    var totalScore: Int?
    var points: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showRating()
    }
    
    func showRating() {
            var rating = ""
            var title = ""
            var color = UIColor.black
            var image = ""
            guard let score = score, let totalScore = totalScore else { return }
            let avgScore = score * 100 / totalScore
            if avgScore < 10 {
                rating = "تحتاج للتدريب :("
                title = "حاول مرة أخرى"
                color = red!
                image = "lose"
            }  else if avgScore < 40 {
                rating = "باجتهادك حتمًا ستصل"
                title = "حاول مرة أخرى"
                color = orange!
                image = "lose"
            } else if avgScore < 60 {
                rating = "جيّد جدًّا"
                title = "واصل التقدم 💪🏻"
                color = orange!
                image = "win"
            } else if avgScore < 80 {
                rating = "أنت رائع!"
                title = "لقد انتصرت!"
                color = lightBlue!
                image = "win"
            } else if avgScore <= 100 {
                rating = "لا أحد أفضل منك 😎"
                title = "انتصار ساحق!"
                color = blue!
                image = "win"
            }
        encourageLabel.text = "\(rating)"
        encourageLabel.textColor = color
        titleLabel.text = "\(title)"
        titleLabel.textColor = color
        imageView.image = UIImage(named: image)
        pointsLabel.text = "\(points!)"
        heartsLabel.text = "\(hearts!)"
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
