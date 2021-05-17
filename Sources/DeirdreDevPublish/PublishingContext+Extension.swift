////
////  PublishingContext+Extension.swift
////  
////
////  Created by Deirdre Saoirse Moen on 5/11/21.
////
//
//import Foundation
//import Ink
//import Plot
//import Files
//import Codextended
//import Publish
//
//public extension PublishingContext {
//
//    // To solve a problem where the instance of a theme can override
//    // the theme's assets, but you want to copy the originals first
//    // then the overrides, and you don't want it throwing hairballs.
//
//    func quietCopyFileToOutput(_ file: File,
//                          targetFolderPath: Path) {
//        quietCopyLocationToOutput(
//            file,
//            targetFolderPath: targetFolderPath
//        )
//    }
//
//    func quietCopyFolderToOutput(_ folder: Folder,
//                            targetFolderPath: Path) {
//        quietCopyLocationToOutput(
//            folder,
//            targetFolderPath: targetFolderPath
//        )
//    }
//
//    func quietCopyLocationToOutput<T: Files.Location>(
//        _ location: T,
//        targetFolderPath: Path
//    ) {
//        let targetFolder = try? targetFolderPath.map {
//            try createOutputFolder(at: $0)
//        }
//
//        do {
//            try location.copy(to: targetFolder ?? folders.output)
//        } catch {
//            let path = Path(location.path(relativeTo: folders.root))
//        }
//    }
//}
