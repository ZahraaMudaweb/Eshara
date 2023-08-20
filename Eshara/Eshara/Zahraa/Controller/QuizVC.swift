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
    var score: Int = 0
    
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
                
                // color the background of the correct/wrong answer
                if question.isAnswered {
                    self.btnsArray[question.correctAns].backgroundColor = .green
                    if question.wrongAns >= 0 {
                        self.btnsArray[question.correctAns].backgroundColor = .red
                    }
                }
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
            loadImages()
        }
    }
    @IBAction func nextStage(_ sender: UIButton) {
        if sender == nextBtn && currentStage == hospitalQuestions.count - 1 {
            let vc = ResultsVC()
            vc.score = score
            navigationController?.pushViewController(vc, animated: true)
        } else {
            nextStage()
        }
    }
    
    @IBAction func didChooseAnswer(_ sender: UIButton) {
        let selectedAnsIndex = answerButtons.firstIndex(of: sender)
    }

    func populateLabels() {

        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid

        guard uid != nil else {
            print("Error Fetching user ID")
            return
        }

    }
    
 }
    


