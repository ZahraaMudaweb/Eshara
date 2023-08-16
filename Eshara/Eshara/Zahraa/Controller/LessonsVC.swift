//
//  LessonsVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 06/08/2023.
//

import UIKit
import FirebaseStorage


class LessonsVC: UIViewController {
        
    private let storage = Storage.storage().reference()
  
    
    var currentStage = 0
    var imagesString = [String]()

    @IBOutlet var translationLabel: UILabel!
    @IBOutlet var lessonsProgress: UIProgressView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        lessonsProgress.progressTintColor = green
        lessonsProgress.trackTintColor = .white

        // Do any additional setup after loading the view.
        fetchImageStrings()
    }
    
    func fetchImageStrings() {
        let storage = Storage.storage()
        let imageRef = storage.reference().child("hospital")
        
        imageRef.listAll(completion:  {
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
        guard currentStage >= 0 && currentStage < imagesString.count else {return}
        
        let imageString = imagesString[currentStage]
        let path = "hospital/\(imageString)"
        let storage = Storage.storage().reference(withPath: path)
    
        let translation = imageString.replacingOccurrences(of: ".png", with: "")
        
        storage.getData(maxSize:  (104857666), completion: {
            (data, error) in
            if let error = error {
                print(error)
            } else if let image = data {
                let myImage = UIImage(data: image)
                self.imageView.image = myImage
                self.translationLabel.text = "الترجمة: \(translation)"
                self.updateUI()
            }
        })
    }
    
    func updateUI() {
        lessonsProgress.progress = Float(currentStage + 1) / Float(imagesString.count)
    }
    
    func nextStage() {
        guard currentStage < imagesString.count else {return}
        currentStage += 1
        updateUI()
        loadImages()
    }
    
    @IBAction func nextStage(_ sender: UIButton) {
        if sender == doneButton && currentStage == imagesString.count - 1 {
            performSegue(withIdentifier: "lessonToQuiz", sender: nil)
        }  else {
            nextStage()
        }
    }
    
    func backStage() {
        guard currentStage < imagesString.count else {return}
        currentStage -= 1
        updateUI()
        loadImages()
    }
    
    @IBAction func backStage(_ sender: UIButton) {
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
