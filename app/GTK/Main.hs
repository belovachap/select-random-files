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

    vBox <- vBoxNew True 10

    source <- fileChooserWidgetNew FileChooserActionSelectFolder
    boxPackStart vBox source PackNatural 10

    destination <- fileChooserWidgetNew FileChooserActionSelectFolder
    boxPackStart vBox destination PackNatural 10

    numFiles <- spinButtonNewWithRange 1 100 1 
    boxPackStart vBox numFiles PackNatural 10

    copy <- buttonNewWithLabel "Copy Random Files"
    copy `onClicked` (do n <- spinButtonGetValueAsInt numFiles
                         s <- fileChooserGetFilename source
                         d <- fileChooserGetFilename destination
                         copyRandomFiles n (fromJust s) ((fromJust d) ++ "/"))
    boxPackStart vBox copy PackNatural 10
    
    containerAdd window vBox
    widgetShowAll window

    mainGUI
