{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Sessao where


import Foundation
import Yesod.Core
import Yesod

getSessaoR :: Handler Html
getSessaoR = do
    sess <- getSession
    defaultLayout
        [whamlet|
            <form method=post>
                <input type=text name=key>
                <input type=text name=val>
                <input type=submit>
            <h1>#{show sess}
        |]


postSessaoR :: Handler Html
postSessaoR = do
    (key, mval) <- runInputPost $ (,) <$> ireq textField "key" <*> iopt textField "val"
    case mval of
        Nothing -> deleteSession key
        Just val -> setSession key val
    liftIO $ print (key, mval)
    redirect SessaoR