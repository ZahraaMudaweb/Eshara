//
//  VideoQuizVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 14/08/2023.
//

import UIKit
import AVFoundation
import FirebaseStorage

class VideoQuizVC: UIViewController {

    @IBOutlet var heartsLabel: UILabel!
    @IBOutlet var option1: UIButton!
    @IBOutlet var option2: UIButton!
    @IBOutlet var option3: UIButton!
    @IBOutlet var option4: UIButton!
    @IBOutlet var videoView: UIView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var quizProgress: UIProgressView!
    @IBOutlet var nextBtn: UIButton!
    
    
    
    
    var categoryName: String?
    var score: Int = 0
    var currentQuestionNumber = 1
    var itemIndex: Int?
    
    var currentStage = 0
    var videosString = [String]()
    var player : AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        videoView.layer.cornerRadius = 20
        videoView.layer.masksToBounds = true
        quizProgress.progressTintColor = green
        quizProgress.trackTintColor = .white
        // Do any additional setup after loading the view.
        fetchVideoStrings()

    }
    
    func fetchVideoStrings() {
        let storage = Storage.storage()
        let videoRef = storage.reference().child("\(categoryName!)")
        
        videoRef.listAll(completion:  {
            (result, error) in
            if let error = error {
                print(error)
            } else {
                self.videosString = result!.items.map {
                    $0.name
                }
                self.loadVideos()
            }
        })
        
    }
    
    func loadVideos() {
        guard currentStage >= 0 && currentStage < videosString.count else {return}
        
        let vidString = "\(questionsArray[itemIndex!][self.currentStage].imgName).mov"
//        let videoString = videosString[currentStage]
        let path = "\(categoryName!)/\(vidString)"
        let storage = Storage.storage().reference(withPath: path)
            
        storage.downloadURL(completion: {
            (url, error) in
            if let error = error {
                print(error)
            } else if let videoUrl = url {
                
                self.player = AVPlayer(url: videoUrl)
                
                let playerLayer = AVPlayerLayer(player: self.player)
                
                playerLayer.frame = self.videoView.bounds
                playerLayer.videoGravity = .resizeAspectFill
                self.videoView.layer.addSublayer(playerLayer)
                
                //play video
                self.playVideo()
                
                self.questionLabel.text = questionsArray[self.itemIndex!][self.currentStage].questionText
                self.option1.titleLabel?.text = questionsArray[self.itemIndex!][self.currentStage].options[0]
                self.option2.titleLabel?.text = questionsArray[self.itemIndex!][self.currentStage].options[1]
                self.option3.titleLabel?.text = questionsArray[self.itemIndex!][self.currentStage].options[2]
                self.option4.titleLabel?.text = questionsArray[self.itemIndex!][self.currentStage].options[3]
                self.updateUI()
            }
        })
    }
    
    func playVideo() {
        player?.play()
    }
    
    func updateUI() {
        quizProgress.progress = Float(currentStage + 1) / Float(questionsArray[self.itemIndex!].count)
    }
    
    func nextStage() {
        guard currentStage < videosString.count else {return}
        currentStage += 1
        loadVideos()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
