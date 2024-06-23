module Lib
    ( copyRandomFiles
    ) where

import System.Directory
import System.Directory.Extra
import System.FilePath
import System.Random
import System.Random.Shuffle

copyRandomFiles :: Int -> FilePath -> FilePath -> IO ()
copyRandomFiles numFiles source destination = do randomGenerator <- getStdGen
                                                 sourceFiles <- listFilesRecursive source
                                                 let copyFiles = take numFiles $ shuffle' sourceFiles (length sourceFiles) randomGenerator
                                                 mapM_ (\file -> copyFile file (destination ++ (takeFileName file) )) copyFiles
