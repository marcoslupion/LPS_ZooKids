//
//  PerfilNinioViewController.swift
//  ZooKids
//
//  Created by Jefferson on 22/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class PerfilNinioViewController: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var imagenjugar: UIImageView!
    @IBOutlet weak var partidas: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var cerrar_admin: UIBarButtonItem!
    
    @IBOutlet weak var graficaBarraPartidas: UIView!
   
    @IBOutlet weak var btonJuega: UIButton!

    @IBOutlet weak var btnCerrarSesion: UIImageView!
    @IBAction func cerrar_niño(sender: UIBarButtonItem) {
        if administrador {
            if presentingViewController is UINavigationController{
                dismissViewControllerAnimated(true, completion: nil)
            } else {
                navigationController!.popViewControllerAnimated(true)
            }
        }
       
        
    }
    @IBAction func cerrar_sesion(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("inicio") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    @IBOutlet weak var graficaResumen: UIView!
    static var ninioIniciado: Alumno!
    //var alumno: Alumno!
    var numFallos:Int16=0
    var numAciertos:Int16=0
    var partidasTotales:[Partida]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        let btnImage = UIButton()
        btnImage.setImage(UIImage(named: "Logo Item Bar"), forState: .Normal)
        btnImage.frame=CGRectMake(0,0,40,40)
        btnImage.userInteractionEnabled = false
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnImage
        self.navigationItem.rightBarButtonItem = rightBarButton
        nombre.text = PerfilNinioViewController.ninioIniciado.nombre_usuario
        let fechaN = PerfilNinioViewController.ninioIniciado.fecha_nacimiento
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let dd = calendar.component(.Day, fromDate: fechaN)
        let mm = calendar.component(.Month, fromDate: fechaN)
        let yy = calendar.component(.Year, fromDate: fechaN)
        let fechaString = String(dd)+" / "+String(mm)+" / "+String(yy)
        fecha.text = fechaString
        foto.image = PerfilNinioViewController.ninioIniciado.foto
        
        if administrador {
            
            segmentedControl.removeSegmentAtIndex(0, animated: false)
            segmentedControl.selectedSegmentIndex = 0
            btonJuega.hidden=true
            btnCerrarSesion.hidden=true
            graficaResumen.hidden=false
            graficaBarraPartidas.hidden = true;
        }else{
            cerrar_admin.title = ""
            btnCerrarSesion.hidden=false
            btonJuega.hidden=false
            graficaResumen.hidden=true
            graficaBarraPartidas.hidden = true;
            profesor = PerfilNinioViewController.ninioIniciado.profesor
        }
        
        cargarDatos()
        
       let barrasPartida = self.childViewControllers[0] as! BarraPartidasViewController
        barrasPartida.partidas=partidasTotales
        barrasPartida.viewDidLoad()
        #if LPS1
            let graficaFinal = self.childViewControllers[1] as! ZooKids.graficaResumen
            #else
            let graficaFinal = self.childViewControllers[1] as! ZooKids2.graficaResumen
            #endif
        graficaFinal.numAciertos = numAciertos
        graficaFinal.numFallos = numFallos
        graficaFinal.viewDidLoad()
        print(PerfilNinioViewController.ninioIniciado.nombre_usuario)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    @IBAction func indexChanged(sender: AnyObject) {
        
        if administrador {
            
            
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                
                btonJuega.hidden=true
                graficaResumen.hidden=false
                graficaBarraPartidas.hidden=true
                
                
            case 1:
                
                btonJuega.hidden=true
                graficaResumen.hidden=true
                graficaBarraPartidas.hidden=false
                
                
            default:
                break
            }
            
        }else{
            
            
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
        
 
 
    }
    
    @IBAction func btnJuega(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("entrada") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func cargarDatos(){
        
        //Aciertos y fallos de un alumno

        let alumno = PerfilNinioViewController.ninioIniciado
        partidasTotales = alumno.partidas
        for partidas in alumno.partidas{
            numFallos += partidas.num_fallos
            numAciertos += partidas.num_aciertos
        }
        /*let nombreAlumno = PerfilNinioViewController.ninioIniciado.nombre_usuario
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestAlumno = NSFetchRequest(entityName: "Alumno")
        fetchRequestAlumno.predicate = NSPredicate(format: "nombre_usuario == %@",nombreAlumno)
        do{
            let resultsAlumno = try managedContext.executeFetchRequest(fetchRequestAlumno)
            
            if (resultsAlumno.count != 0){
                print("alumno encontrado")
                let alumno = resultsAlumno[0] as! Alumno
                partidasTotales = alumno.partidas
                print("partidas totales = ",partidasTotales.count)
                for partidas in alumno.partidas{
                    numFallos += partidas.num_fallos
                    numAciertos += partidas.num_aciertos
                }
            }else{
                print("No se ha encontrado ningún alumno")
            }
            
            try managedContext.save()
            
        }catch{
            print("Error")
        }*/

        //Resultados por partida

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
