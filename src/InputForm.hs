{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module InputForm where

import Yesod.Core
import Yesod
import Foundation
import Data.Text
import Control.Applicative

data Pessoa = Pessoa {nome:: Text , idade::Int } | Nulo deriving Show

getInputFormR :: Handler Html
getInputFormR = do
    person <- runInputGet $ Pessoa
                <$> ireq textField "nome"
                <*> ireq intField "idade"
    defaultLayout [whamlet|<p>#{show person}|]
