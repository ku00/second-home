{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Api
    ( startApp
    , app
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

import Food as Food

type API = Food.CRUD

startApp :: IO ()
startApp = do
  putStrLn "Listening on port 8080"
  run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = getFoods
    :<|> getFood
  where getFoods = return Food.foods
        getFood fid = return $ Food.food fid