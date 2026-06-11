//
//  PersistenceController+CoreDataStorage.swift
//  RandomUserChallenge
//

import CoreData
import Foundation
import RandomUserData
import RandomUserDomain

// MARK: - PersistenceController + RandomUserStorage

extension PersistenceController: RandomUserStorage {

    // MARK: Public

    public func save(_ users: [User]) async throws {
        let context = container.newBackgroundContext()
        try await context.perform {
            let existingIDs = try self.fetchExistingIDs(in: context)
            let deletedIDs = try self.fetchDeletedIDs(in: context)
            let startIndex = try self.nextSortIndex(in: context)

            let newUsers = users.enumerated().filter {
                !existingIDs.contains($0.element.id) &&
                    !deletedIDs.contains($0.element.id)
            }

            for (offset, user) in newUsers {
                let entity = UserEntity(context: context)
                entity.sortIndex = Int32(startIndex + offset)
                entity.isDeletedFlag = false
                self.map(user: user, to: entity)
            }

            try context.save()
        }
    }

    public func loadUsers() async throws -> [User] {
        let context = container.newBackgroundContext()
        return try await context.perform {
            let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
            request.predicate = NSPredicate(format: "isDeletedFlag == false")
            request.sortDescriptors = [NSSortDescriptor(key: "sortIndex", ascending: true)]
            return try context.fetch(request).compactMap(self.map(entity:))
        }
    }

    public func search(query: String) async throws -> [User] {
        guard !query.isEmpty else { return try await loadUsers() }
        let context = container.newBackgroundContext()
        return try await context.perform {
            let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
            request.predicate = NSPredicate(
                format: "isDeletedFlag == false AND (nameFirst CONTAINS[cd] %@ OR nameLast CONTAINS[cd] %@ OR email CONTAINS[cd] %@)",
                query,
                query,
                query,
            )
            request.sortDescriptors = [NSSortDescriptor(key: "sortIndex", ascending: true)]
            return try context.fetch(request).compactMap(self.map(entity:))
        }
    }

    public func delete(userId: String) async -> [User] {
        let context = container.newBackgroundContext()
        do {
            return try await context.perform {
                let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
                request.predicate = NSPredicate(format: "id == %@", userId)
                request.fetchLimit = 1
                if let entity = try context.fetch(request).first {
                    entity.isDeletedFlag = true
                    try context.save()
                }
                let remaining = NSFetchRequest<UserEntity>(entityName: "UserEntity")
                remaining.predicate = NSPredicate(format: "isDeletedFlag == false")
                remaining.sortDescriptors = [NSSortDescriptor(key: "sortIndex", ascending: true)]
                return try context.fetch(remaining).compactMap(self.map(entity:))
            }
        } catch {
            return []
        }
    }

    public func get(userId: String) async throws -> User? {
        let context = container.newBackgroundContext()
        return try await context.perform {
            let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
            request.predicate = NSPredicate(format: "id == %@ AND isDeletedFlag == false", userId)
            request.fetchLimit = 1
            return try context.fetch(request).first.flatMap(self.map(entity:))
        }
    }

    public func clear() async {
        let context = container.newBackgroundContext()
        do {
            try await context.perform {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
                request.predicate = NSPredicate(format: "isDeletedFlag == false")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                try context.execute(deleteRequest)
                try context.save()
            }
        } catch { }
    }

    // MARK: Private

    private nonisolated func fetchExistingIDs(in context: NSManagedObjectContext) throws -> Set<UUID> {
        let request = NSFetchRequest<NSDictionary>(entityName: "UserEntity")
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["id"]
        let results = try context.fetch(request)
        return Set(results.compactMap { $0["id"] as? UUID })
    }

    private nonisolated func fetchDeletedIDs(in context: NSManagedObjectContext) throws -> Set<UUID> {
        let request = NSFetchRequest<NSDictionary>(entityName: "UserEntity")
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = ["id"]
        request.predicate = NSPredicate(format: "isDeletedFlag == true")
        let results = try context.fetch(request)
        return Set(results.compactMap { $0["id"] as? UUID })
    }

    private nonisolated func nextSortIndex(in context: NSManagedObjectContext) throws -> Int {
        let request = NSFetchRequest<NSDictionary>(entityName: "UserEntity")
        request.resultType = .dictionaryResultType
        request.predicate = NSPredicate(format: "isDeletedFlag == false")
        let expression = NSExpressionDescription()
        expression.name = "maxSortIndex"
        expression.expression = NSExpression(
            forFunction: "max:",
            arguments: [NSExpression(forKeyPath: "sortIndex")],
        )
        expression.expressionResultType = .integer32AttributeType
        request.propertiesToFetch = [expression]
        let result = try context.fetch(request).first
        let max = result?["maxSortIndex"] as? Int32 ?? -1
        return Int(max) + 1
    }

}
