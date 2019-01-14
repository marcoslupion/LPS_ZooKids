//
//  ListaAlumnosViewController.swift
//  ZooKids
//
//  Created by Carmen Esther on 13/01/2019.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import CoreData

class ListaAlumnosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var btnOrdenar: UIButton!
    
    @IBOutlet weak var listaOrdenar: UITableView!
    
    let arrayOrdenacion: NSMutableArray = ["Nombre","Fecha"]
    
    @IBOutlet weak var listaAlumnos: UIView!
    
    var alumnos:[Alumno]!
    var listaPartidas = [Partida]()
    var nAciertos: Int16 = 0
    var nErrores: Int16 = 0
    var orden: String!
    //var profesor: Profesor!
    static var cantAciertos: Double = 0.0
    
    @IBAction func salir(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("viewAdmin") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        let btnImage = UIButton()
        btnImage.setImage(UIImage(named: "Logo Item Bar"), forState: .Normal)
        btnImage.frame=CGRectMake(0,0,40,40)
        btnImage.userInteractionEnabled = false
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnImage
        self.navigationItem.rightBarButtonItem = rightBarButton
        super.viewDidLoad()
        btnOrdenar.layer.borderWidth = 1
        btnOrdenar.layer.borderColor = UIColor.blackColor().CGColor
        listaOrdenar.layer.borderWidth = 1
        listaOrdenar.layer.borderColor = UIColor.blackColor().CGColor
        listaOrdenar.hidden = true
        orden = "nombre_usuario"
        cargarDatos()
        let alumnosTabla = self.childViewControllers[0] as! AlumnosTableViewController
        alumnosTabla.listaAlumnos = alumnos
        alumnosTabla.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func seleccionarOrden(sender: UIButton) {
        if listaOrdenar.hidden == true {
            listaOrdenar.hidden = false
        } else {
            listaOrdenar.hidden = true
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)->Int{
            return arrayOrdenacion.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = arrayOrdenacion[indexPath.row] as? String
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let selectedItem = arrayOrdenacion.objectAtIndex(indexPath.row) as! NSString
        btnOrdenar.setTitle(selectedItem as String, forState: UIControlState.Normal)
        if selectedItem.isEqualToString("Nombre"){
        // ORDENAMOS POR NOMBRE EL CONTAINER
            orden = "nombre_usuario"
            cargarDatos()
            listaAlumnos.reloadInputViews()
        } else if selectedItem.isEqualToString("Fecha"){
        // ORDENAMOS POR FECHA EL CONTAINER
            orden = "fecha_nacimiento"
            cargarDatos()
            listaAlumnos.reloadInputViews()
        }
        listaOrdenar?.hidden = true
    }
    
    func cargarDatos(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Alumno")
        let sortDescriptor = NSSortDescriptor(key:"fecha_nacimiento", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors?.append(sortDescriptor)
        fetchRequest.predicate = NSPredicate(format: "profesor.nombre_usuario == %@", profesor.nombre_usuario)
        do {
            let resultados = try managedContext.executeFetchRequest(fetchRequest)
            alumnos = resultados as! [Alumno]
            
        }
        catch {
            print("Error al cargar los alumnos")
        }
        let fetchRequestPartida = NSFetchRequest(entityName: "Partida")
        do {
            let resultadosPartidas = try managedContext.executeFetchRequest(fetchRequestPartida)
            listaPartidas = resultadosPartidas as! [Partida]
        }
        catch {
            print("Error al cargar las partidas")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
