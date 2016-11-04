//
//  Pin+CoreDataClass.swift
//  Virtual Tourist
//
//  Created by Tobias Helmrich on 03.11.16.
//  Copyright © 2016 Tobias Helmrich. All rights reserved.
//

import Foundation
import CoreData


public class Pin: NSManagedObject {
    convenience init(withLatitude latitude: Double, andLongitude longitude: Double, intoContext context: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Pin", in: context) else {
            fatalError("Unable to find entity with name Pin")
        }
        
        self.init(entity: entity, insertInto: context)
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    func removePhotos() {
        self.photos = nil
    }
    
    func removePhotos(withIds ids: [String]) {
        // Create a fetch request for the Photo entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        // Instantiate an empty array of NSPredicate
        var predicates = [NSPredicate]()
        
        // Create a predicate for each ID in the array that was passed in as an array and append it to the array created above
        for id in ids {
            let predicate = NSPredicate(format: "id == %@", argumentArray: [id])
            predicates.append(predicate)
        }
        
        // Create a compound predicate that connects all the ID predicates with "OR"
        let idCompoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        // Create a pin predicate which should check if the photos actually belong to the pin and create a compound predicate by
        // connecting the pin predicate and the ID compound predicate with "AND"
        let pinPredicate = NSPredicate(format: "pin == %@", argumentArray: [self])
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [idCompoundPredicate, pinPredicate])
        
        // Assign the resulting predicate to the fetch request's predicate property and create a batch delete request from the fetch request
        fetchRequest.predicate = compoundPredicate
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // Try to execute the batch delete request and save it to the context
        do {
            try CoreDataStack.stack.persistentContainer.viewContext.execute(batchDeleteRequest)
            CoreDataStack.stack.save()
        } catch {
            print("Error when trying to delete photos from database: \(error)")
        }
    }
    
}