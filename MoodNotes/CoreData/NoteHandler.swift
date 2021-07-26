//
//  NoteHandler.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//

import Foundation
import UIKit
import CoreData
 
class NoteHandler: NSObject{
    
    static let sharedInstance = NoteHandler()
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    private let context = NoteHandler.managedContext
    
   
    
    
    func fetchAllNotes(completion: @escaping (Status, [Note]) -> ()){
        do{
            let notes = try context.fetch(Note.fetchRequest()) as! [Note]
            
            completion(.success, notes)
            
        }catch{
            completion(.failure, [])
        }
    }
    
    func createNewNote(title: String, notes: String, mood: String, completion: @escaping(Status) -> ()){
        let newNote = Note(context: context)
        newNote.title = title
        newNote.content = notes
        newNote.mood = mood
        newNote.createdOn = Date()
        newNote.updatedOn = Date()
        
        do{
            try context.save()
            completion(.success)
        }catch{
            completion(.failure)
        }
    }
    
    func deleteNote(note: Note, completion: @escaping(Status) -> ()){
        context.delete(note)
        
        do{
            try context.save()
            completion(.success)
        }catch{
            completion(.failure)
        }
    }
    
    func updateNote(noteToUpdate: Note, newTitle: String, newNotes: String, newMood: String, completion: @escaping(Status) -> ()){
        
        noteToUpdate.title = newTitle
        noteToUpdate.content = newNotes
        noteToUpdate.mood = newMood
        noteToUpdate.updatedOn = Date()
        
        do{
            try context.save()
            completion(.success)
        }catch{
            completion(.failure)
        }
    }
}

