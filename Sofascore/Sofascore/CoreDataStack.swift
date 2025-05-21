
import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    private init() {}
    

    lazy var persistentContainer: NSPersistentContainer = {
        // Ovdje stavi ime svog .xcdatamodeld fajla bez ekstenzije!
        let container = NSPersistentContainer(name: "SofascoreModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
