module A where

import Data.Functor (void)
import Language.Javascript.JSaddle (JSM)
import GHCJS.DOM (currentDocument)

main :: IO ()
main = putStrLn "it worked"

kaboom :: JSM ()
kaboom = void $ currentDocument
