//
//  EventViewController.swift
//  Calendar3
//
//  Created by Sunil Gurung on 5/23/17.
//  Copyright © 2017 Impactit. All rights reserved.
//

import UIKit
import CoreData

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
    @IBOutlet weak var EventView: UITableView!
    
    var subjectarray:[String] = []
    var notearray:[String] = []
    var datearray:[Date] = []
    //let date : String = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
   
    

    // Calling the AppDelgate to Utilize the CoreData
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // insertEventDate()
       
    }

//    func insertEventDate()  {
//        for i in 0..<subjectarray.count{
//            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
//
//            let newEvents = NSEntityDescription.insertNewObject(forEntityName: "Events", into: context)
//            
//            var subjects = ["Weekly Sport Event","Cultural Program","Weekly Sport Event","Cultural Program"]
//            var notes = ["5 days remaining","5 days remaining","5 days remaining","5 days remaining"]
//            
//            newEvents.setValue(subjects[i], forKey: "subject")
//            newEvents.setValue(notes[i], forKey: "note")
//           
//            
//            do{
//                try context.save()
//                print("SAVE")
//            }
//            catch{
//                print("Error...!")
//            }
//
//    }
    
    func insertEventDate() {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        //Dummy Values
        
        let Subjects = ["Weekly Sports Event","Cultural Program","Weekly Sports Event","Cultural Program"]
        let Notes = ["5 days remanining","5 days remanining","5 days remanining","5 days remanining"]
        let Dates = ["2017-01-14","2017-02-14","2017-03-14","2017-04-14"]
        for i in 0..<Subjects.count{
            let newEntry = NSEntityDescription.insertNewObject(forEntityName: "Events", into: context)
            newEntry.setValue(Subjects[i], forKey: "subject")
            newEntry.setValue(Notes[i], forKey: "note")
            newEntry.setValue(Dates[i], forKey: "date")
            
            do{
                try context.save()
            }
            catch{
                print("Error...!")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchevents()
    }
    
    func fetchevents()  {
        
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let subject =  result.value(forKey: "subject") as? String
                    {
                        
                        subjectarray.append(subject)
                        
                    }
                    if let notes =  result.value(forKey: "note") as? String
                    {
                        notearray.append(notes)
                    }
                   
                }
            }
            
            self.EventView.reloadData()
        }
            
        catch{
            print("Error")
        }
        
        
    }

       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellevent = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        
        cellevent.lblsubject.text = subjectarray[indexPath.row]
        cellevent.lblnote.text = notearray[indexPath.row]
        
        
        return (cellevent)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
