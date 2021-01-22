{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}


module Handler.AppliForm where

import Foundation
import Yesod.Core
import Yesod
import Control.Applicative
import Data.Text           (Text)
import Data.Time

newtype UserId = UserId Int
    deriving Show

data Blog = Blog
    { blogTitle    :: Text
    , blogContents :: Textarea
    , blogUser     :: UserId
    , blogPosted   :: UTCTime
    }
    deriving Show


data Pessoa = Pessoa {nome::Text, idade :: Int} deriving Show

formPessoa :: Form Pessoa
formPessoa = renderDivs $ Pessoa
    <$> areq textField "Nome" Nothing
    <*> areq intField  "Idade" Nothing

-- Form Blog eh um sinonimo 
form :: UserId -> Form Blog
form userId = renderDivs $ Blog
    <$> areq textField "Title" Nothing
    <*> areq textareaField "Contents" Nothing
    <*> pure userId
    <*> lift (liftIO getCurrentTime)

getAppliFormR :: Handler Html
getAppliFormR =  do
    let userId = UserId 5 
    ((res, widget), enctype) <- runFormPost $ form userId
    defaultLayout
        [whamlet|
            <p>Previous result: #{show res}
            <form method=post action=@{AppliFormR} enctype=#{enctype}>
                ^{widget}
                <input type=submit>
        |]
                
postAppliFormR :: Handler Html
postAppliFormR = getAppliFormR


{-

data Pessoa = Pessoa {nome::Text, idade :: Int} deriving Show

formPessoa :: Form Pessoa
formPessoa = renderDivs $ Pessoa
    <$> areq textField "Nome" Nothing
    <*> areq intField  "Idade" Nothing

getAppliFormR :: Handler Html
getAppliFormR =  do
    --let userId = UserId 5 
    ((_, widget), enctype) <- runFormPost $ formPessoa
    defaultLayout
        [whamlet|
            <form method=post action=@{AppliFormR} enctype=#{enctype}>
                ^{widget}
                <input type=submit>
        |]
                
postAppliFormR :: Handler Html
postAppliFormR = do
    --let userId = UserId 5 
    ((res, _), _) <- runFormPost $ formPessoa
    defaultLayout
        [whamlet|
            <p>Previous result: #{show res}
        |]    
                
                
-}