module Main (main) where

import System.Directory
import System.Directory.Extra
import System.Environment
import System.FilePath
import System.Random
import System.Random.Shuffle

main :: IO ()
main = do [numFiles, source, destination] <- getArgs
          randomGenerator <- getStdGen
          sourceFiles <- listFilesRecursive source
          let copyFiles = take (read numFiles) $ shuffle' sourceFiles (length sourceFiles) randomGenerator
          mapM_ (\file -> copyFile file (destination ++ (takeFileName file) )) copyFiles
