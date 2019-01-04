//
//  PerfilNinioViewController.swift
//  ZooKids
//
//  Created by Jefferson on 22/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit

class PerfilNinioViewController: UIViewController {

    @IBOutlet weak var imagenjugar: UIImageView!
    @IBOutlet weak var partidas: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var graficaBarraPartidas: UIView!
   
    @IBOutlet weak var btonJuega: UIButton!

    @IBOutlet weak var graficaResumen: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graficaResumen.hidden=true
        graficaBarraPartidas.hidden = true;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func indexChanged(sender: AnyObject) {
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            btonJuega.hidden=false
            graficaResumen.hidden=true
            graficaBarraPartidas.hidden=true
            
            
            
        case 1:
            
            btonJuega.hidden=true
            graficaResumen.hidden=false
            graficaBarraPartidas.hidden=true
            
            
        case 2:
            btonJuega.hidden=true
            graficaResumen.hidden=true
            graficaBarraPartidas.hidden=false
            
            
        default:
            break
        }
 
 
    }
    
    @IBAction func btnJuega(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("juego") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
