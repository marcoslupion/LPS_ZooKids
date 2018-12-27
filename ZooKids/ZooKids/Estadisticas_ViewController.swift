//
//  Estadisticas_ViewController.swift
//  ZooKids
//
//  Created by Jose F. Ruiz Zamora on 25/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class Estadisticas_ViewController: ViewController {

    @IBOutlet weak var selectorEstadistica: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargar estadísticas al iniciar la ventana
        self.cargarEstadisticas()
        
        //Actualizar valores al cambiar de pestaña
        selectorEstadistica.addTarget(self, action: #selector(self.changeValue(_:)), forControlEvents: .ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cargarEstadisticas(){
    
        //Cargar fallos totales
        //Configurar contexto
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //Partidas totales
        let fetchRequestPartidas = NSFetchRequest(entityName: "Partida")
        var preguntasTotales:Int
        do{
            let resultsPartidas = try managedContext.executeFetchRequest(fetchRequestPartidas)
            preguntasTotales = resultsPartidas.count * 25
            //Errores
            var erroresTotales = 0 as Int16
            for partida in resultsPartidas as! [Partida]{
                erroresTotales += partida.num_fallos
            }
            print("Errores totales = ",String(erroresTotales))
                        
        }catch{
            print("Error")
        }
        
        //Fallos totales
        let fetchRequestFallos = NSFetchRequest(entityName: "Fallo")
        var fallosTotales : Int16
        var tipoAnimalMap = Dictionary<String,Int16>()
        tipoAnimalMap = initializeDictionary()
        do{
            let resultsFallos = try managedContext.executeFetchRequest(fetchRequestFallos)
            fallosTotales = 0
            
            for fallo in resultsFallos as! [Fallo]{
                print("Fallo ",fallo.tipo_animal," total de ",fallo.fallos)
                fallosTotales += fallo.fallos
                //tipoAnimalMap[fallo.tipo_animal] = (tipoAnimalMap[fallo.tipo_animal])!+1
                tipoAnimalMap[fallo.tipo_animal] = fallo.fallos
                
            }

            
            //print("Fallos totales = ",fallosTotales)
            
        }
        catch{
            print("error")
        }
        
        
        //Por género
        
        
    }
    
    func changeValue(segment: UISegmentedControl){
        if(segment.selectedSegmentIndex == 0){
            print("segment = 0")
        }else if(segment.selectedSegmentIndex == 1){
            print("segment = 1")
        }else if(segment.selectedSegmentIndex == 2){
            print("segment = 2")
        }else{
            print("error, valor = ",segment.selectedSegmentIndex)
        }
    }
    
    func initializeDictionary() -> Dictionary<String,Int16>{
     
        var map = Dictionary<String,Int16>()
        var opciones_totales = [String]();
        opciones_totales.append("Mamífero");
        opciones_totales.append("Pez");
        opciones_totales.append("Anfibio");
        opciones_totales.append("Reptil");
        opciones_totales.append("Invertebrado");
        opciones_totales.append("Insecto");
        opciones_totales.append("Ave");
        
        for str in opciones_totales{
            map[str] = 0
        }
        return map;
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