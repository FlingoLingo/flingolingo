//
//  DeckBackHeaderView.swift
//  
//
//  Created by Алиса Вышегородцева on 13.04.2023.
//

import SwiftUI
import UIComponents

struct DeckBackHeaderView: View {

    private let title: String
    private let backButtonClicked: (() -> Void)
    private let editButtonClicked: (() -> Void)
    private let deleteButtonClicked: (() -> Void)

    init(title: String,
         backButtonClicked: @escaping () -> Void,
         editButtonClicked: @escaping () -> Void,
         deleteButtonClicked: @escaping () -> Void) {
        self.title = title
        self.backButtonClicked = backButtonClicked
        self.editButtonClicked = editButtonClicked
        self.deleteButtonClicked = deleteButtonClicked
    }

    var body: some View {
        HStack {
            HStack {
                Button(action: backButtonClicked) {
                    Icons.leftArrow
                        .foregroundColor(SColors.mainText)
                }
                Text(title)
                    .font(SFonts.subtitle)
                    .foregroundColor(SColors.mainText)
                    .padding(.leading, CommonConstants.smallSpacing)
                Spacer()
                Menu {
                    Button(action: editButtonClicked) {
                        HStack {
                            Text("changeName")
                            Icons.pencil
                        }
                    }
                    Button(role: .destructive, action: deleteButtonClicked) {
                        HStack {
                            Text("delete")
                            Icons.trash
                        }
                    }
                } label: {
                    Icons.dots
                        .foregroundColor(SColors.mainText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
