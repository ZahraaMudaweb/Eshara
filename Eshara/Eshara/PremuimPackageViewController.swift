//
//  PremuimPackageViewController.swift
//  Eshara
//
//  Created by iOSdev on 23/08/2023.
//

import UIKit

class PremiumPackageViewController: UIViewController {
    
    
    @IBOutlet weak var viewPkg1: UIView!
    
    @IBOutlet weak var viewPkg2: UIView!
    
    
    @IBOutlet weak var viewPkg3: UIView!
    
    @IBOutlet var tenBDLabel: UILabel!
    @IBOutlet var threeMothenLabel: UILabel!
    @IBOutlet var packegStander: UILabel!
    
    
    
    
    @IBOutlet var premuimPackeg: UILabel!
    @IBOutlet var fiftenBHD: UILabel!
    @IBOutlet var sixmothnLabel: UILabel!
    
    
    
    @IBOutlet var twintyBHD: UILabel!
    @IBOutlet var yearPackeg: UILabel!
    @IBOutlet var elitePackeg: UILabel!
    
    
    
    
    
    
    
    @IBOutlet var pay1: UIButton!
    
    @IBOutlet var pay2: UIButton!
    
    @IBOutlet var pay3: UIButton!
    
    var package:PremiumPackage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        standerpackeg()
        PremiumPackeg()
        Elite()
        adjustView()
        
        // Do any additional setup after loading the view.
    }
    
    
    func adjustView(){
        
        viewPkg1.layer.cornerRadius = 35
        viewPkg1.clipsToBounds = true
        
        viewPkg2.layer.cornerRadius = 35
        viewPkg2.clipsToBounds = true
        
        viewPkg3.layer.cornerRadius = 35
        viewPkg3.clipsToBounds = true
        
        
        pay1.layer.cornerRadius = 35
        pay1.clipsToBounds = true
        
        pay2.layer.cornerRadius = 35
        pay2.clipsToBounds = true
        
        pay3.layer.cornerRadius = 35
        pay3.clipsToBounds = true
        
    
    }
    
    @IBAction func payPackage1(_ sender: UIButton) {
        
       
        performSegue(withIdentifier: "pay1", sender: self)
            
//            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
//
//            let viewController = storyboard.instantiateViewController(withIdentifier: "PayPackeg") as! PremiumPayViewController
//  navigationController?.pushViewController(viewController, animated: true)
            
            
        
            //performSegue(withIdentifier: "paySeg", sender: sender)
        
    }
    
    
    
    @IBAction func payPackage2(_ sender: UIButton) {
        
        performSegue(withIdentifier: "pay2", sender: self)
        
    }
    
    @IBAction func payPackage3(_ sender: UIButton) {
        
        performSegue(withIdentifier: "pay3", sender: self)
        
    }
    
//    @IBSegueAction func packegSegu(_ coder: NSCoder, sender: Any?) -> PremiumPayViewController?
//    {
//
//        if let vc = sender as? PremiumPayViewController, let pkg = self.package {
//
//            return PremiumPayViewController(coder: coder, packeag:pkg)
//        }
//
//        return PremiumPayViewController(coder: coder)
//    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "pay1"
        {
            if let destions  = segue.destination as? PremiumPayViewController
            {

                self.package = PremiumPackage(id: 1, name: "Standard Package", price: "5 BHD", period: "3 Months", issueDate: "", expiryDatre: "")
       
                destions.packeag = self.package
                print("Hiiiii")

            }
        }
        else if segue.identifier == "pay2"
        {
            if let destions  = segue.destination as? PremiumPayViewController
            {

                self.package = PremiumPackage(id: 2, name: "Premium Package", price: "15 BHD", period: "6 Months", issueDate: "", expiryDatre: "")
       
                destions.packeag = self.package

            }
        }
        else if segue.identifier == "pay3"
        {
            if let destions  = segue.destination as? PremiumPayViewController
            {

                self.package = PremiumPackage(id: 3, name: "Elite Package", price: "20 BHD", period: "12 Months", issueDate: "", expiryDatre: "")
       
                destions.packeag = self.package

            }
        }
    }
    
    
    func standerpackeg()
    {
        packegStander.text = "Stander Packeg"
        package?.name  = packegStander.text!
        tenBDLabel.text = "5 BHD"
        package?.price = tenBDLabel.text!
        threeMothenLabel.text = "Three months"
        package?.period = threeMothenLabel.text!
    }
    
    func PremiumPackeg()
    {
        premuimPackeg.text = "Premuim Packeg"
        package?.name = premuimPackeg.text!
        fiftenBHD.text = "15 BHD"
        package?.price = fiftenBHD.text!
        sixmothnLabel.text = "Six Months"
        package?.period = sixmothnLabel.text!
    }
    
    func Elite()
    {
        elitePackeg.text = "Elite Packeg"
        package?.name = elitePackeg.text!
        twintyBHD.text = "20 BHD"
        package?.price = twintyBHD.text!
        yearPackeg.text = "one Year"
        package?.period = yearPackeg.text!
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
