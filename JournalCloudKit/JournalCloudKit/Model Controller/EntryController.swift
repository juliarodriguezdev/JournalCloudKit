//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Julia Rodriguez on 7/8/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    // shared instance: singleton
    static let sharedInstance = EntryController()
    private init() {}

    // source of truth
    var entries: [Entry] = []
    
    // MARK: - CRUD
    
    // Save
    func saveEntry(entry: Entry, completion: @escaping (Bool) ->()) {
        
        let entryRecord = CKRecord(entry: entry)
        
        CKContainer.default().privateCloudDatabase.save(entryRecord) { (record, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n --- /n \(error)")
                completion(false)
                return
        
            }
            guard let foundRecord = record,
                let entry = Entry(record: foundRecord) else { completion(false); return }
            
            self.entries.append(entry)
        
            completion(true)
        }
        
    }
    
    // Create
    func addEntryWith(title: String, body: String, completion: @escaping (Bool) -> Void) {
        let EntryToAdd = Entry(title: title, bodyText: body)
       
        saveEntry(entry: EntryToAdd, completion: completion)
        
    }
    
    // Read
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryConstants.RecordType, predicate: predicate)
        
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let foundEntry = records else { completion(false); return }
            
            let fetchedEntry = foundEntry.compactMap({Entry(record: $0)})
            
            self.entries = fetchedEntry
            
            completion(true)
        }
    }
    
    // Update
    
    // Delete
}
