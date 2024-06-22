module Main (main) where

import Lib

import Graphics.UI.Gtk
import Graphics.Rendering.Cairo

main :: IO ()
main = do
    initGUI
    window      <- windowNew
    drawingArea <- drawingAreaNew
    containerAdd window drawingArea

    drawingArea `onExpose` (\_ -> renderScene drawingArea)
    window `onDestroy` mainQuit

    windowSetDefaultSize window 640 480
    widgetShowAll window
    mainGUI

renderScene :: DrawingArea -> IO Bool
renderScene da = do
    dw <- widgetGetDrawWindow da
    renderWithDrawable dw $ do setSourceRGBA 0.5 0.5 0.5 1.0
                               moveTo 100.0 100.0
                               showText "HelloWorld"
    return True

