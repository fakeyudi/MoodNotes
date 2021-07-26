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
    
    var openedNote = Note()
    var noteType: NoteType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldAttributes(noteString: "")
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
    }
    
    func setUpScreen(for noteType: NoteType){
        switch noteType {
        case .existing:
            TitleTextField.text = openedNote.title
            setTextFieldAttributes(noteString: openedNote.content ?? "")
        case .new:
            setTextFieldAttributes(noteString: "")
        }
    }
   
    func setTextFieldAttributes(noteString: String){
        notesTextView.placeholder = "Write Your Thoughts Here..."
        notesTextView.textColor = UIColor(named: "TextPrimary")
        notesTextView.font = UIFont(name: "CircularStd-Book", size: 18)
        notesTextView.text = noteString
    }
    
}
