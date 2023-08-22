//
//  QuizVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 06/08/2023.
//

import UIKit
import AVFoundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class QuizVC: UIViewController {

    @IBOutlet var heartsLabel: UILabel!
    @IBOutlet var option1: UIButton!
    @IBOutlet var option2: UIButton!
    @IBOutlet var option3: UIButton!
    @IBOutlet var option4: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var quizProgress: UIProgressView!
    @IBOutlet var answerButtons: [UIButton]!
    var btnsArray = [UIButton]()
    
    var categoryName: String?
    
    var currentStage = 0
    var imagesString = [String]()
    var player : AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        quizProgress.progressTintColor = green
        quizProgress.trackTintColor = .white
        // Do any additional setup after loading the view.
        fetchImageStrings()

    }
    
    func fetchImageStrings() {
        let storage = Storage.storage()
        let imgRef = storage.reference().child("hospital")
        
        imgRef.listAll(completion:  {
            (result, error) in
            if let error = error {
                print(error)
            } else {
                self.imagesString = result!.items.map {
                    $0.name
                }
                self.loadImages()
            }
        })
        
    }
    
    func loadImages() {
        btnsArray = [option1, option2, option3, option4]

        guard currentStage >= 0 && currentStage < hospitalQuestions.count else {return}
        
        let imgString = "\(hospitalQuestions[self.currentStage].imgName).png"
        let path = "hospital/\(imgString)"
        let storage = Storage.storage().reference(withPath: path)

        storage.getData(maxSize:  (104857666), completion: {
            (data, error) in
            if let error = error {
                print(error)
            } else if let image = data {
                let myImage = UIImage(data: image)
                self.imageView.image = myImage
                let question = hospitalQuestions[self.currentStage]
                self.questionLabel.text = question.questionText
                self.option1.setTitle(question.options[0], for: .normal)
                self.option2.setTitle(question.options[1], for: .normal)
                self.option3.setTitle(question.options[2], for: .normal)
                self.option4.setTitle(question.options[3], for: .normal)
                self.updateUI()
            }
        })
    }
    
    func updateUI() {
        quizProgress.progress = Float(currentStage) / Float(hospitalQuestions.count)
    }
    
    func nextStage() {
        if currentStage < hospitalQuestions.count {
            currentStage += 1
            enableButtons()
            loadImages()
        }
    }
    @IBAction func nextStage(_ sender: UIButton) {
        if sender == nextBtn && currentStage == hospitalQuestions.count - 1 {
            let vc = ResultsVC()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            nextStage()
        }
    }
    
    @IBAction func didChooseAnswer(_ sender: UIButton) {
        btnsArray = [option1, option2, option3, option4]
        var question = hospitalQuestions[self.currentStage]
        
        question.isAnswered = true
        self.btnsArray[question.correctAns].backgroundColor = .green

        switch sender {
        case option1:
            if question.correctAns == 0 {
                increasePoints()
            } else  {
                decreaseHearts()
                self.btnsArray[0].backgroundColor = .red
            }
            disableButtons()
        case option2:
            if  question.correctAns == 1{
                increasePoints()
            } else {
                decreaseHearts()
                self.btnsArray[1].backgroundColor = .red
            }
            disableButtons()
        case option3:
            if question.correctAns == 2 {
                increasePoints()
            } else {
                decreaseHearts()
                self.btnsArray[2].backgroundColor = .red
            }
            disableButtons()
        case option4:
            if question.correctAns == 3 {
                increasePoints()
            } else {
                decreaseHearts()
                self.btnsArray[3].backgroundColor = .red
            }
            disableButtons()
        default:
            question.isAnswered = false
            enableButtons()
        }
    
    }
     
    func increasePoints() {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        // increase user points
        ref.child("user").child(uid!).observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for child in result {
                if child.key == "points" {
                    guard let value = child.value as? Int else {return}
                    let newValue = value + 10
                    ref.child("user").child(uid!).updateChildValues(["points" : (newValue)])
                    let vc = ResultsVC()
                    vc.score += 10
                }
                
            }
        })
    }

    func decreaseHearts() {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        // decrease user hearts
        ref.child("user").child(uid!).observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for child in result {
                if child.key == "hearts" {
                    guard let value = child.value as? Int else {return}
                    let newValue = value - 1
                    ref.child("user").child(uid!).updateChildValues(["hearts" : (newValue)])
                    self.heartsLabel.text = "\(newValue)"
                }
            }
        })
    
    }
    func disableButtons() {
        option1.isEnabled = false
        option2.isEnabled = false
        option3.isEnabled = false
        option4.isEnabled = false
    }
    func enableButtons() {
        option1.isEnabled = true
        option2.isEnabled = true
        option3.isEnabled = true
        option4.isEnabled = true
        option1.backgroundColor = .clear
        option2.backgroundColor = .clear
        option3.backgroundColor = .clear
        option4.backgroundColor = .clear

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
