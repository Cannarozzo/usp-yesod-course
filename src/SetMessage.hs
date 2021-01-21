{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module SetMessage where


import Foundation
import Yesod.Core
import Yesod


getSetMessageR :: Handler Html
getSetMessageR = defaultLayout
    [whamlet|
        <form method=post action=@{SetMessageR}>
            My message is: #
            <input type=text name=message>
            <button>Go
    |]

postSetMessageR :: Handler Html
postSetMessageR = do
    msg <- runInputPost $ ireq textField "message"
    setMessage $ toHtml msg
    redirect SetMessageR
