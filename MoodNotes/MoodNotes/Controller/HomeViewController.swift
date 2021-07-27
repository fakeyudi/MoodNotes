//
//  HomeViewController.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 26/7/21.
//

import UIKit
import BetterSegmentedControl

class HomeViewController: UIViewController {

    @IBOutlet weak var notesCV: UICollectionView!
    @IBOutlet weak var segmentView: UIView!
    
    let moodSegmentControl = BetterSegmentedControl(
        frame: CGRect(x: 16, y: 20, width: 315, height: 32.0),
        segments: LabelSegment.segments(withTitles: ["All", "Great", "Okayish","Bad"],
                                        normalFont: UIFont(name: "CircularStd-Medium", size: 16),
                                        normalTextColor: UIColor(named: "TextSecondary"),
                                        selectedFont: UIFont(name: "CircularStd-Bold", size: 16),
                                        selectedTextColor: UIColor(named: "TextPrimary")),
        options:[.backgroundColor(.clear),
                 .indicatorViewBackgroundColor(UIColor(named: "SubButton") ?? .lightGray),
                 .cornerRadius(16.0),
                 .animationSpringDamping(1.0)])
    
    var noteType: NoteType!
    var allNotes: [Note]?
    
    var filteredNotes = [Note](){
        didSet{
                DispatchQueue.main.async {
                    self.notesCV.reloadData()
                }
        }
    }
    var selectedNote = Note()
    
    var notesHandler = NoteHandler.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesCV.delegate = self
        notesCV.dataSource = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "BG")
        
        moodSegmentControl.addTarget(self,
                                     action: #selector(HomeViewController.moodSegmentedControlValueChanged(_:)),
                                     for: .valueChanged)
        
        self.segmentView.addSubview(moodSegmentControl)
        moodSegmentControl.setIndex(0)
        moodSegmentControl.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAllNotes()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        moodSegmentControl.setIndex(0)
        filteredNotes = allNotes ?? []
    }
    
    @IBAction func addNewNoteBtn(_ sender: Any) {
        noteType = .new
        self.performSegue(withIdentifier: segues.newNote, sender: self)
    }
    
    @objc func moodSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        switch sender.index {
        case 0:
            print("Show All Notes")
            filteredNotes = allNotes ?? []
        case 1:
            print("Show Good Mood Notes")
            filteredNotes = allNotes?.filter{ $0.mood == moods.great } ?? []
        case 2:
            print("Show Okayish Mood Notes")
            filteredNotes = allNotes?.filter{ $0.mood == moods.ok } ?? []
        case 3:
            print("Show Bad Mood Notes")
            filteredNotes = allNotes?.filter{ $0.mood == moods.bad } ?? []
        default:
            print("DEFAULT VALUE")
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 163, height: 163)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.notesCell, for: indexPath) as! NotesCollectionViewCell
        cell.setupCell(for: filteredNotes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedNote = filteredNotes[indexPath.row]
        noteType = .existing
        self.performSegue(withIdentifier: segues.newNote, sender: self)
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
