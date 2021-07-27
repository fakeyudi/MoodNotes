//
//  NotesCollectionViewCell.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 27/7/21.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var cellBGView: UIView!
    
    //Casting Data to Cell
    func setupCell(for note: Note){
        cellBGView.clipsToBounds = true
        cellBGView.layer.cornerRadius = 12
        moodLabel.text = getMoodString(for: note.mood ?? "")
        titleLabel.text = note.title
        lastUpdateLabel.text = note.updatedOn?.string(format: "d MMM yyyy")
    }
    
    private func getMoodString(for mood: String)->String{
        switch mood{
        case moods.great:
            return "Great Mood"
        case moods.ok:
            return "Okayish Mood"
        case moods.bad:
            return "Bad Mood"
        default:
            return ""
        }
    }
    
}
