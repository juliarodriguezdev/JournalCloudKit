//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Julia Rodriguez on 7/8/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    // class properties
    let title: String
    let bodyText: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: EntryConstants.typeKey, recordID: ckRecordID)
        record.setValue(title, forKey: EntryConstants.TitleKey)
        record.setValue(bodyText, forKey: EntryConstants.BodyKey)
        record.setValue(timestamp, forKey: EntryConstants.TimestampKey)
        
        return record
    
    }
    
    // class initializer
    init(title: String, bodyText: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    // failable initializer to pass in CKRecord
    init?(record: CKRecord) {
        // CKRecord.RecordType, recordID: CKRecord.ID = CKRecord.ID()) {
        // guard against keys
        guard let title = record[EntryConstants.TitleKey] as? String,
            let bodyText = record[EntryConstants.BodyKey] as? String,
            let timestamp = record[EntryConstants.TimestampKey] as? Date,
            let ckRecordID = record[EntryConstants.ckRecordIDKey] as? CKRecord.ID else { return nil }
        // set values for model properties
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
        
    }
    
}
struct EntryConstants {
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let ckRecordIDKey = "ckRecordID"
    static let typeKey = "Entry"
    
}


