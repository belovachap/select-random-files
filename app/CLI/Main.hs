module Main (main) where

import Lib

import System.Environment

main :: IO ()
main = do [numFiles, source, destination] <- getArgs
          copyRandomFiles (read numFiles) source destination
