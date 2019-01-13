//
//  AlumnosTableViewController.swift
//  ZooKids
//
//  Created by Alberto Fuentes on 17/12/18.
//  Copyright © 2018 ual. All rights reserved.
//

import UIKit
import CoreData

class AlumnosTableViewController: UITableViewController {
    var listaAlumnos = [Alumno]()
    var listaPartidas = [Partida]()
    var nAciertos: Int16 = 0
    var nErrores: Int16 = 0
    var orden: String!
    static var cantAciertos: Double = 0.0
    override func viewDidLoad() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.56, green:0.91, blue:0.85, alpha:1.0)
        let btnImage = UIButton()
        btnImage.setImage(UIImage(named: "Logo Item Bar"), forState: .Normal)
        btnImage.frame=CGRectMake(0,0,40,40)
        btnImage.userInteractionEnabled = false
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnImage
        self.navigationItem.rightBarButtonItem = rightBarButton
        orden = "nombre_usuario"
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func salir(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Admin", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("viewAdmin") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Alumno")
        let sortDescriptor = NSSortDescriptor(key: orden, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let resultados = try managedContext.executeFetchRequest(fetchRequest)
            listaAlumnos = resultados as! [Alumno]
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
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaAlumnos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let alumno = listaAlumnos[indexPath.row]
        nAciertos = 0
        nErrores = 0
        AlumnosTableViewController.cantAciertos = 0.0
        var i: Int16 = 0
        for partida in listaPartidas{
            print("partida :", i)
            print("nombre partida : ", partida.alumno.nombre_usuario, "nombre user: ", alumno.nombre_usuario)
            if partida.alumno.nombre_usuario == alumno.nombre_usuario{
                print("coincide")
                print("aciertos: ", partida.num_aciertos, " errores: ", partida.num_fallos)
                nAciertos += partida.num_aciertos
                nErrores += partida.num_fallos
                i+=1
            }
        }
        let total = nAciertos + nErrores
        AlumnosTableViewController.cantAciertos = (Double(nAciertos) / Double(total))*10
        print(AlumnosTableViewController.cantAciertos)
        let cell = tableView.dequeueReusableCellWithIdentifier("celdaAlumno") as! AlumnoTableViewCell
        
        cell.nombre.text = alumno.nombre_usuario
        let fecha = alumno.fecha_nacimiento
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let dd = calendar.component(.Day, fromDate: fecha)
        let mm = calendar.component(.Month, fromDate: fecha)
        let yy = calendar.component(.Year, fromDate: fecha)
        let fechaString = String(dd)+" / "+String(mm)+" / "+String(yy)
        cell.fecha.text = fechaString
        cell.foto.image = alumno.foto
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
