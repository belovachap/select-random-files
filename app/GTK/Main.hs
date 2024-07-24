module Main (main) where

import Lib

import Graphics.UI.Gtk

fromJust :: Maybe a -> a
fromJust (Just a) = a
fromJust Nothing = error "Can't be Nothing!"

main :: IO ()
main = do
    initGUI
    
    window <- windowNew
    window `onDestroy` mainQuit

    table <- tableNew 4 2 False
    tableSetRowSpacings table 10
    tableSetColSpacings table 10

    sourceLabel <- labelNew (Just "Source Folder:")
    source <- fileChooserWidgetNew FileChooserActionSelectFolder
    widgetSetSizeRequest source 600 300
    tableAttachDefaults table sourceLabel 0 1 0 1
    tableAttachDefaults table source 1 2 0 1

    destinationLabel <- labelNew (Just "Destination Folder:")
    destination <- fileChooserWidgetNew FileChooserActionSelectFolder
    widgetSetSizeRequest destination 600 300
    tableAttachDefaults table destinationLabel 0 1 1 2
    tableAttachDefaults table destination 1 2 1 2

    numFilesLabel <- labelNew (Just "Number of Files:")
    numFiles <- spinButtonNewWithRange 1 100 1 
    tableAttachDefaults table numFilesLabel 0 1 2 3
    tableAttachDefaults table numFiles 1 2 2 3

    copy <- buttonNewWithLabel "Copy Random Files"
    copy `onClicked` (do n <- spinButtonGetValueAsInt numFiles
                         s <- fileChooserGetFilename source
                         d <- fileChooserGetFilename destination
                         copyRandomFiles n (fromJust s) ((fromJust d) ++ "/"))
    tableAttachDefaults table copy 0 2 3 4
    
    containerAdd window table
    widgetShowAll window

    mainGUI
