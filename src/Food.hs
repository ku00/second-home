{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Food
  ( Food(..)
  , CRUD
  , foods
  , food
  ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

data Food = Food
  { foodId :: Int
  , name   :: String
  , price  :: Int
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''Food)

type CRUD = "foods" :> Get '[JSON] [Food]
       :<|> "food" :> Capture "id" Int :> Get '[JSON] Food

foods :: [Food]
foods = [ Food 1 "Nirareba Itame" 860
        , Food 2 "Moyashi to Nirareba Itame" 860
        , Food 3 "Nira-Niku-Tamago Itame" 860
        , Food 4 "Butareba Itame" 860
        , Food 5 "Butaniku to Ninniku no Meitame" 860
        ]

food :: Int -> Food
food fid = head $ filter (\(Food fid' _ _) -> fid == fid') foods