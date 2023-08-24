//
//  PremuimPackageViewController.swift
//  Eshara
//
//  Created by iOSdev on 23/08/2023.
//

import UIKit

class PremiumPackageViewController: UIViewController {
    
    
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
        
        // Do any additional setup after loading the view.
    }
    
    
    func adjustView(){
        
        
    }
    
    @IBAction func payPackage1(_ sender: UIButton) {
        
        if(sender == pay1)
        {
            performSegue(withIdentifier: "pay1", sender: self)
            
//            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
//
//            let viewController = storyboard.instantiateViewController(withIdentifier: "PayPackeg") as! PremiumPayViewController
//
//            self.package?.id = 1
//            self.package?.name = "Standard Package"
//            self.package?.period = "3 Months"
//            self.package?.price = "5 BD"
//            self.package?.issueDate = ""
//            self.package?.expiryDatre = ""
//
//            navigationController?.pushViewController(viewController, animated: true)
            
            
        
            //performSegue(withIdentifier: "paySeg", sender: sender)
        }
        else if(sender == pay2)
        {
            package?.id = 1
            package?.name = "Premium Package"
            package?.period = "6 Months"
            package?.price = "15 BD"
            package?.issueDate = ""
            package?.expiryDatre = ""
            //performSegue(withIdentifier: "paySeg", sender: sender)
            
        }
        else if(sender == pay3)
        {
            
            package?.id = 1
            package?.name = "Elite Package"
            package?.period = "12 Months"
            package?.price = "20 BD"
            package?.issueDate = ""
            package?.expiryDatre = ""
            //performSegue(withIdentifier: "paySeg", sender: sender)
        }
        else
        {
            
        }
        
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

                self.package = PremiumPackage(id: 1, name: "", price: "5", period: "", issueDate: "", expiryDatre: "")
                
//                self.package?.id = 1
//                self.package?.name = "Standard Package"
//                self.package?.period = "3 Months"
//                self.package?.price = "5 BD"
//                self.package?.issueDate = ""
//                self.package?.expiryDatre = ""
//
                destions.packeag = self.package
                print("Hiiiii")



//                destions.packeag?.period = package!.period
//                destions.packeag?.price = package!.price
//                destions.packeag?.name = package!.name

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
        premuimPackeg.text = "PremuimPackeg"
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
