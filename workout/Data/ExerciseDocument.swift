//
//  ExerciseDocument.swift
//  workout
//
//  Created by user0862 on 2025/12/6.
//

import SwiftUI
import UniformTypeIdentifiers

struct ExerciseDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }

    var exercises: [Exercise]

    init(exercises: [Exercise]) {
        self.exercises = exercises
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.exercises = try JSONDecoder().decode([Exercise].self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(exercises)
        return FileWrapper(regularFileWithContents: data)
    }
}
