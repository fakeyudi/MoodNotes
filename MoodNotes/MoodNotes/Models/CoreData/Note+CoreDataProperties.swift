//
//  Note+CoreDataProperties.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var createdOn: Date?
    @NSManaged public var updatedOn: Date?
    @NSManaged public var mood: String?

}

extension Note : Identifiable {

}
