//
//  MRCoreDataManager.swift
//  MRCoreDataManager
//  Version 1.0.0
//
//  Created by Manish Rathi on 6/1/17.
//  Copyright © 2017 Manish Rathi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import CoreData

public class MRCoreDataManager {
    /**
     *  Get the singleton object of MRCoreDataManager.
     *
     *  @return sharedInstance
     *
     *  @since 1.0.0
     */
    public static let sharedInstance = MRCoreDataManager()
    
    /**
     *  Hold CoreData Stack's persistentContainer
     *
     *  @note This is read-Only.
     *
     *  @since 1.0.0
     */
    public private(set) var persistentContainer: NSPersistentContainer?

    /**
     *  Call this API to initialize CoreData Stack. Normally should be called only once.
     *
     *  @note AppDelegate didFinish method is the best place to call this API.
     *
     *  @since 1.0.0
     */
    public func initialize(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    /**
     *  Add EntityData with EntityName. User has option to instant save NSManagedObjectContext.
     *
     *  @note default value for 'instantSave' is false.
     *
     *  @since 1.0.0
     */
    @discardableResult
    public func addDataForEntityName(_ entityName: String, entityData: [String: Any], instantSave: Bool = false) -> NSManagedObject? {
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: (persistentContainer?.viewContext)!)
        if updateManagedObject(managedObject, entityData: entityData) {
            return managedObject
        }
        return nil
    }
    
    /**
     *  Get EntityData with EntityName.
     *
     *  @since 1.0.0
     */
    @discardableResult
    public func fetchDataForEntityName(_ entityName: String, predicate: NSPredicate? = nil) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.resultType = .managedObjectResultType
        do {
            let fetchResult = try persistentContainer?.viewContext.fetch(fetchRequest)
            return fetchResult as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            print("fetchRequest -> Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return nil
    }
    
    /**
     *  Update NSManagedObject data. User has option to instant save NSManagedObjectContext.
     *
     *  @note default value for 'instantSave' is false.
     *
     *  @since 1.0.0
     */
    @discardableResult
    public func updateManagedObject(_ object: NSManagedObject, entityData: [String: Any], instantSave: Bool = false) -> Bool {
        let attributes = object.entity.attributesByName
        let keys = Array(attributes.keys)
        for index in 0..<keys.count {
            let key = keys[index]
            let value = entityData[key]
            object.setValue(value, forKey: key)
        }
        return instantSave ? saveContext() : true
    }

    /**
     *  Delete NSManagedObject. User has option to instant save NSManagedObjectContext.
     *
     *  @note default value for 'instantSave' is false.
     *
     *  @since 1.0.0
     */
    @discardableResult
    public func deleteManagedObject(_ object: NSManagedObject, instantSave: Bool = false) -> Bool {
        persistentContainer?.viewContext.delete(object)
        return instantSave ? saveContext() : true
    }
    
    /**
     *  Get EntityData with EntityName.
     *
     *  @since 1.0.0
     */
    @discardableResult
    public func deleteAllManagedObjectForEntityName(_ entityName: String, predicate: NSPredicate? = nil, instantSave: Bool = false) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.resultType = .managedObjectResultType
        do {
            let fetchResult = try persistentContainer?.viewContext.fetch(fetchRequest) as? [NSManagedObject]
            for managedObject in fetchResult ?? [] {
                deleteManagedObject(managedObject)
            }
        } catch {
            let nserror = error as NSError
            print("deleteAllRequest -> Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return instantSave ? saveContext() : true
    }
    
    /**
     *  Core Data Saving support.
     *
     *  @since 1.0.0
     */
    @discardableResult
    public func saveContext () -> Bool {
        let context = persistentContainer?.viewContext
        if context?.hasChanges ?? false {
            do {
                try context?.save()
                return true
            } catch {
                let nserror = error as NSError
                print("saveContext -> Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return false
    }
}
