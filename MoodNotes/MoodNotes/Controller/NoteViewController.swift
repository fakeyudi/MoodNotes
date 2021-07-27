//
//  NoteViewController.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var rightNavBtn: UIBarButtonItem!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var deleteNavBtn: UIBarButtonItem!
    
    
    var openedNote = Note()
    var noteType: NoteType!
    
    var editingAllowed: Bool = false
    var newMood = moods.Default
    
    var notesHandler = NoteHandler.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldAttributes(noteString: "")
        
        TitleTextField.addUnderLine()
        
        setUpScreen(for: noteType)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "BG")
        
        let moodTap = UITapGestureRecognizer(target: self, action: #selector(NoteViewController.changeMood(_:)))
        moodLabel.isUserInteractionEnabled = true
        moodLabel.addGestureRecognizer(moodTap)
        
        ModalTransitionMediator.instance.setListener(listener: self)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let noteTitle = TitleTextField.text ?? ""
        let noteContent = notesTextView.text ?? ""
        if editingAllowed{
            if noteType == .new{
                if !noteTitle.isEmpty && !noteContent.isEmpty{
                    if newMood != moods.Default || !moodLabel.isHidden{
                        self.saveNewNote(noteTitle: noteTitle, noteContent: noteContent, mood: newMood)
                    }
                    else{
                        self.performSegue(withIdentifier: segues.setMood, sender: self)
                    }
                }
                else{
                    //Empty Note Alert
                }
            }
            else if noteType == .existing{
                if !noteTitle.isEmpty && !noteContent.isEmpty{
                    if newMood != moods.Default{
                        updateNote(noteTitle: noteTitle, noteContent: noteContent, mood: newMood)
                    }
                    else{
                        self.performSegue(withIdentifier: segues.setMood, sender: self)
                    }
                }
                else{
                    //Empty Note Alert
                }
            }
        }
        
        else if !editingAllowed{
            editingAllowed = true
            setupEditing()
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        //Create Alert
        notesHandler.deleteNote(note: openedNote) { status in
            switch status{
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .failure:
                print("Unable to delete Note")
            }
        }
    }
    
    @objc
    func changeMood(_ sender: UILabel){
        self.performSegue(withIdentifier: segues.setMood, sender: self)
    }
    
    
    func setUpScreen(for noteType: NoteType){
        switch noteType {
        case .existing:
            TitleTextField.text = openedNote.title
            setTextFieldAttributes(noteString: openedNote.content ?? "")
            moodLabel.text = "Mood: \(openedNote.mood ?? "idk")"
            lastUpdateLabel.text = "Last Updated On: \(openedNote.updatedOn?.string(format: "d MMM yyyy") ?? "Date not Found")"
            deleteNavBtn.isEnabled = true
            deleteNavBtn.tintColor = UIColor(named: "TextPrimary")
            editingAllowed = false
        case .new:
            deleteNavBtn.isEnabled = false
            deleteNavBtn.tintColor = UIColor(named: "BG")
            moodLabel.isHidden = true
            lastUpdateLabel.text = "Created: Just Now"
            editingAllowed = true
            setTextFieldAttributes(noteString: "")
        }
        setupEditing()
    }
    
    func setupEditing(){
        if editingAllowed{
            rightNavBtn.image = UIImage(named: "Save")
            TitleTextField.isEnabled = true
            notesTextView.isEditable = true
        }
        else{
            rightNavBtn.image = UIImage(named: "Edit")
            TitleTextField.isEnabled = false
            notesTextView.isEditable = false
        }
    }
    
    func setTextFieldAttributes(noteString: String){
        notesTextView.placeholder = "Write Your Thoughts Here..."
        notesTextView.textColor = UIColor(named: "TextPrimary")
        notesTextView.font = UIFont(name: "CircularStd-Book", size: 18)
        notesTextView.text = noteString
    }
    
}

//MARK:-Note Handler Methods-

extension NoteViewController{
    func saveNewNote(noteTitle: String, noteContent: String, mood: String){
        notesHandler.createNewNote(title: noteTitle, notes: noteContent, mood: mood) { status in
            switch status{
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .failure:
                print("Unable to save Note")
            }
        }
    }
    
    func updateNote(noteTitle: String, noteContent: String, mood: String){
        notesHandler.updateNote(noteToUpdate: openedNote, newTitle: noteTitle, newNotes: noteContent, newMood: mood) { status in
            switch status{
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .failure:
                print("Unable to update Note")
            }
        }
    }
    
}

//MARK:- Mood Delegate-

extension NoteViewController: ModalTransitionListener{
    func popoverDismissed(mood: String) {
        print("NEW MOOD:::::: \(mood)")
        self.newMood = mood
        self.moodLabel.text = "Mood: \(newMood)"
        self.moodLabel.isHidden = false
    }
    
    func mood(mood: String) {
        print("NEW MOOD:::::: \(mood)")
        self.newMood = mood
        self.moodLabel.text = "Mood: \(mood)"
        self.moodLabel.isHidden = false
    }
    
    
}
