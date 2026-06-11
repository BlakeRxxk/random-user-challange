//
//  PersistenceController.swift
//  RandomUserChallenge
//

import CoreData
import Foundation
import OSLog

public final class PersistenceController {

    // MARK: Lifecycle

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RandomUserChallenge")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { [weak self] _, error in
            guard let error = error as NSError? else { return }
            self?.logger.error("Unresolved error \(error), \(error.userInfo)")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: Internal

    static let shared = PersistenceController()

    let container: NSPersistentContainer
    let logger = Logger()

}
