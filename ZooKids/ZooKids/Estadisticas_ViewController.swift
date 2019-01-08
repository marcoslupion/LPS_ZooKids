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
    @IBOutlet weak var estadisticaResultado: UIView!
    @IBOutlet weak var textoGrafica: UILabel!
    @IBOutlet weak var EstadisticaGenero: UIView!
    
    @IBOutlet weak var EstadisticaFallosTotales: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cargar estadísticas al iniciar la ventana
        self.cargarEstadisticas()
        
        //Actualizar valores al cambiar de pestaña
        //selectorEstadistica.addTarget(self, action: #selector(self.changeValue(_:)), forControlEvents: .ValueChanged)
        
        
        estadisticaResultado.hidden=false
        EstadisticaGenero.hidden=true
        textoGrafica.hidden = false
        EstadisticaFallosTotales.hidden=true
        
        
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
        var preguntasTotales:Int = 0
        var erroresTotales = 0 as Int16
        do{
            let resultsPartidas = try managedContext.executeFetchRequest(fetchRequestPartidas)
            preguntasTotales = resultsPartidas.count * 25
            //Errores
            for partida in resultsPartidas as! [Partida]{
                erroresTotales += partida.num_fallos
            }
            
        }catch{
            print("Error")
        }
        
        //Fallos totales
        let fetchRequestFallos = NSFetchRequest(entityName: "Fallo")
        var fallosTotales : Int16 = 0
        var tipoAnimalMap = Dictionary<String,Int16>()
        tipoAnimalMap = initializeDictionary()
        do{
            let resultsFallos = try managedContext.executeFetchRequest(fetchRequestFallos)
            fallosTotales = 0
            
            for fallo in resultsFallos as! [Fallo]{
                //print("Fallo ",fallo.tipo_animal," total de ",fallo.fallos, "fallos")
                fallosTotales += fallo.fallos
                tipoAnimalMap[fallo.tipo_animal] = fallo.fallos
                
            }
            
        }
        catch{
            print("error")
        }
        
        
        //Por género
        let fetchRequestGenero = NSFetchRequest(entityName: "Partida")
        var numAciertosH:Int16 = 0
        var numFallosH:Int16 = 0
        var numAciertosM:Int16 = 0
        var numFallosM:Int16 = 0
        
        do{
            
            let resultsFallosGenero = try managedContext.executeFetchRequest(fetchRequestGenero)
            
            for partida in resultsFallosGenero as! [Partida]{
                //print("partida id = ",partida.id_partida)
                if(partida.alumno.sexo == "M"){
                    //print("género = M")
                    numAciertosM += partida.num_aciertos
                    numFallosM += partida.num_fallos
                }else{
                    //print("género = H")
                    numAciertosH += partida.num_aciertos
                    numFallosH += partida.num_fallos
                }
            }
            
            
        }
        catch{
            print("error")
        }

        
        //Datos para las estadísticas
        let aciertosTotales = numAciertosM + numFallosH
        
        print("Errores totales = ",String(erroresTotales))
        print("Preguntas totales = ",preguntasTotales)
        print("Fallos totales = ",fallosTotales," ; fallos H = ",numFallosH," ; fallos M = ",numFallosM)
        print("Aciertos totales = ",aciertosTotales," ; aciertos H = ",numAciertosH,
              " ; aciertos M = ",numAciertosM)
        
        

        
    }
    
    
    @IBAction func indexChanged(sender: AnyObject) {
        
        
        switch selectorEstadistica.selectedSegmentIndex
        {
        case 0:
            estadisticaResultado.hidden=false
            EstadisticaGenero.hidden=true
            textoGrafica.hidden = false
            EstadisticaFallosTotales.hidden=true
            
        case 1:
            estadisticaResultado.hidden=true
            EstadisticaGenero.hidden=false
            textoGrafica.hidden = true
            EstadisticaFallosTotales.hidden=true
           
            
        case 2:
      
             estadisticaResultado.hidden=true
             EstadisticaGenero.hidden=true
            textoGrafica.hidden = true
            EstadisticaFallosTotales.hidden=false

            
        default:
            break
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
