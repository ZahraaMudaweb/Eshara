//
//  AddReviewViewController.swift
//  Eshara
//
//  Created by A M on 8/15/23.
//

import UIKit

class AddReviewViewController: UIViewController {

    
    var AddstudentRevie: AddStudentrevie?
    
    @IBOutlet var StudentCommentView: UIView!
    
    @IBOutlet var CommenttextField: UITextField!
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var StudentButtonComment: UIButton!
    
    
    @IBOutlet var rateLabel: UILabel!
    
    @IBOutlet var oneLabel: UILabel!
    
    
    
     init?(coder: NSCoder, AddstudentRevie: AddStudentrevie?)
    {
        self.AddstudentRevie = AddstudentRevie
        super.init(coder: coder)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        // Do any additional setup after loading the view.
      
        CommenttextField.addTarget(self, action: #selector(canAddComment(_:)), for: .editingChanged)
        canAddComment(CommenttextField)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
 
    
    
    @objc func canAddComment(_ textField: UITextField)
    {
       
        let comment = CommenttextField.text ?? ""
        StudentButtonComment.isEnabled = !comment.isEmpty
    }
    
    
    @IBAction func textField(_ sender: UITextField)
    {
        canAddComment(CommenttextField)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveButton" else {return}
        
        let comment = CommenttextField.text ?? ""
        let rate = oneLabel.text ?? ""
        let studentname = titleLabel.text ?? ""
       AddstudentRevie = AddStudentrevie(studentRate: rate, StudentCommrnt: comment, studentname: studentname)
      
    }

}
