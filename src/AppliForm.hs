{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}


module AppliForm where

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

form :: UserId -> Form Blog
form userId = renderDivs $ Blog
    <$> areq textField "Title" Nothing
    <*> areq textareaField "Contents" Nothing
    <*> pure userId
    <*> lift (liftIO getCurrentTime)

getAppliFormR :: Handler Html
getAppliFormR =  do
    let userId = UserId 5 -- again, see the authentication chapter
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