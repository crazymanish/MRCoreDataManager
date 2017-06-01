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

import Foundation
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
    public func addDataForEntityName(_ entityName: String, entityData: [String: Any], instantSave: Bool = false) -> NSManagedObject {
     
        //TODO: Implement ADD Functioanlity
        return NSManagedObject() // This is temp line, just to avoid compile error.
    }
    
    /**
     *  Get EntityData with EntityName.
     *
     *  @since 1.0.0
     */
    public func dataForEntityName(_ entityName: String, predicate: NSPredicate? = nil) -> [NSManagedObject] {
        
        //TODO: Implement GET Functioanlity
        return []   // This is temp line, just to avoid compile error.
    }
    
    /**
     *  Update NSManagedObject data. User has option to instant save NSManagedObjectContext.
     *
     *  @note default value for 'instantSave' is false.
     *
     *  @since 1.0.0
     */
    public func updateManagedObject(_ object: NSManagedObject, entityData: [String: Any], instantSave: Bool = false) -> Bool {
        
        //TODO: Implement UPDATE Functioanlity
        return true   // This is temp line, just to avoid compile error.
    }

    /**
     *  Delete NSManagedObject. User has option to instant save NSManagedObjectContext.
     *
     *  @note default value for 'instantSave' is false.
     *
     *  @since 1.0.0
     */
    public func deleteManagedObject(_ object: NSManagedObject, instantSave: Bool = false) -> Bool {
        
        //TODO: Implement DELETE Functioanlity
        return true   // This is temp line, just to avoid compile error.
    }
    
    /**
     *  Core Data Saving support.
     *
     *  @since 1.0.0
     */
    public func saveContext () {
        let context = persistentContainer?.viewContext
        if context?.hasChanges ?? false {
            do {
                try context?.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
