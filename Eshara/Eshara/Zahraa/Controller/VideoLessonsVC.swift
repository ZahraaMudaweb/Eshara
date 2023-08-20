//
//  VideoLessonsVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 13/08/2023.
//

import UIKit
import FirebaseStorage
import AVFoundation

class VideoLessonsVC: UIViewController {

    private let storage = Storage.storage().reference()
    var categoryName : String?
    var itemIndex: Int?
    var currentStage = 0
    var videosString = [String]()
    var player : AVPlayer?

    @IBOutlet var translationLabel: UILabel!
    @IBOutlet var lessonsProgress: UIProgressView!
    @IBOutlet var videoView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nextButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        videoView.layer.cornerRadius = 20
        videoView.layer.masksToBounds = true
        lessonsProgress.progressTintColor = green
        lessonsProgress.trackTintColor = .white

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
        
        let videoString = videosString[currentStage]
        let path = "\(categoryName!)/\(videoString)"
        let storage = Storage.storage().reference(withPath: path)
    
        let translation = videoString.replacingOccurrences(of: ".mov", with: "")
        
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
                
                self.translationLabel.text = "الترجمة: \(translation)"
                self.updateUI()
            }
        })
    }
    
    func playVideo() {
        player?.play()
    }
    
    @IBAction func replayBtn(_ sender: Any) {
        if player?.rate == 0 {
            player?.seek(to: CMTime.zero)
            player?.play()
        }
    }
    
    func updateUI() {
        lessonsProgress.progress = Float(currentStage) / Float(videosString.count)
    }
    
    func nextStage() {
        guard currentStage < videosString.count else {return}
        currentStage += 1
        loadVideos()
    }
    
    @IBAction func nextStage(_ sender: UIButton) {
        if sender == nextButton && currentStage == videosString.count - 1 {
            let preVC = storyboard?.instantiateViewController(identifier: "preQuiz") as! preQuizVC
            preVC.categoryName = categoryName
            preVC.itemIndex = itemIndex
            navigationController?.pushViewController(preVC, animated: true)
        }  else {
            nextStage()
        }
    }
    
    func backStage() {
        guard currentStage < videosString.count else {return}
        currentStage -= 1
        updateUI()
        loadVideos()
    }
    
    @IBAction func backStage(_ sender: Any) {
        backStage()
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
