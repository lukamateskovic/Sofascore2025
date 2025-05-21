import CoreData
import UIKit

class CoreDataService {
    static let shared = CoreDataService()
    private let context: NSManagedObjectContext
    
    init() {
        context = CoreDataStack.shared.persistentContainer.viewContext
    }
    
    func saveEvents(_ events: [Event]) {
        for event in events {
            let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", event.id)
            
            if let existingEvent = try? context.fetch(request).first {
                update(existingEvent, with: event)
            } else {
                createNewEvent(from: event)
            }
        }
        saveContext()
    }
    
    private func createNewEvent(from event: Event) {
        let newEvent = EventEntity(context: context)
        newEvent.id = Int32(event.id)
        newEvent.homeTeam = event.homeTeam.name
        newEvent.awayTeam = event.awayTeam.name
        newEvent.startTimestamp = event.startTimestamp
        newEvent.status = event.status.rawValue
        newEvent.homeScore = Int32(event.homeScore ?? -1)
        newEvent.awayScore = Int32(event.awayScore ?? -1)
        
        let league = getOrCreateLeague(from: event.league)
        newEvent.league = league
    }
    
    private func getOrCreateLeague(from league: League) -> LeagueEntity {
        let request: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", league.id)
        
        if let existingLeague = try? context.fetch(request).first {
            return existingLeague
        } else {
            let newLeague = LeagueEntity(context: context)
            newLeague.id = Int32(league.id)
            newLeague.name = league.name
            newLeague.country = league.country.name
            newLeague.logoUrl = league.logoUrl?.absoluteString
            return newLeague
        }
    }
    
    func getEventCount() -> Int {
        let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        return (try? context.count(for: request)) ?? 0
    }
    
    func getLeagueCount() -> Int {
        let request: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        return (try? context.count(for: request)) ?? 0
    }
    
    func deleteAllData() {
        deleteAll(entityName: "EventEntity")
        deleteAll(entityName: "LeagueEntity")
        deleteAll(entityName: "CountryEntity")
        saveContext()
    }
    
    private func deleteAll(entityName: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error deleting \(entityName): \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func update(_ existingEvent: EventEntity, with event: Event) {
        existingEvent.id = Int32(event.id)
        existingEvent.homeTeam = event.homeTeam.name
        existingEvent.awayTeam = event.awayTeam.name
        existingEvent.startTimestamp = event.startTimestamp
        existingEvent.status = event.status.rawValue
        existingEvent.homeScore = Int32(event.homeScore ?? -1)
        existingEvent.awayScore = Int32(event.awayScore ?? -1)
        
        let league = getOrCreateLeague(from: event.league)
        existingEvent.league = league
    }
}

