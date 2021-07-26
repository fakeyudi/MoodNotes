//
//  HomeViewController.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var notesCV: UICollectionView!
    
    var noteType: NoteType!
    var allNotes = [Note](){
        didSet{
            if allNotes.count != 0{
                DispatchQueue.main.async {
                    self.notesCV.reloadData()
                }
            }
        }
    }
    var selectedNote = Note()
    
    var notesHandler = NoteHandler.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesCV.delegate = self
        notesCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAllNotes()
    }
    
    @IBAction func addNewNoteBtn(_ sender: Any) {
        noteType = .new
        self.performSegue(withIdentifier: segues.newNote, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segues.newNote{
            let vc = segue.destination as! NoteViewController
            vc.openedNote = selectedNote
            vc.noteType = noteType
        }
    }

}

//MARK:-CollectionView Methods-

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

//MARK:-CoreData loading Methods-

extension HomeViewController{
    
    ///Fetching All Notes
    func loadAllNotes(){
        notesHandler.fetchAllNotes { status, notes in
            switch status{
            case .success:
                self.allNotes = notes
            case .failure:
                print("failure case")
                //TODO:- Show Alert Possibly
                
            }
        }
    }
    
}
