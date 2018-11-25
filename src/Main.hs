module Main where
  import           Data.Maybe           (isJust, Maybe(..), listToMaybe)
  import           Data.List            (intersperse)
  import           Safe                 (readMay)
  import           Control.Applicative  (liftA2)

  type Node = (Path, Int)
  type Path = [Int]

  minpath :: [Path] -> Maybe [Node]
  minpath = foldr go Nothing
     where go xs Nothing = Just $ map (\x -> ([x], x)) xs
           go xs ys = liftA2 zippy (minpath [xs]) ys

           zippy xs ys = zipWith go xs (zip ys (tail ys))
             where go (p, v) ((p1, v1), (p2, v2))
                    | v1 < v2 = (p1 ++ p, v1 + v)
                    | otherwise = (p2 ++ p, v2 + v)

  showResult :: Maybe [Node] -> IO ()
  showResult (Just [(path, v)]) = putStrLn $ "Minimum path is: "
              ++ unwords (intersperse "+" (show <$> path))
              ++ "=" ++ show v
  showResult _ = putStrLn "Invalid Sequence"

  convertWords :: String -> Maybe [Int]
  convertWords = traverse (readMay :: (String -> Maybe Int)) . words

  main :: IO ()
  main = do
    content <- getContents
    let xs = sequence $ convertWords <$> lines content
    showResult $ xs >>= minpath
