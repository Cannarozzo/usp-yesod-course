{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes           #-}


module Foundation where

import Yesod.Core
import Yesod
import Data.Text


data App = App

mkYesodData "App" $(parseRoutesFile "routes.yesodroutes")

instance Yesod App where -- Sessao setada para 1 minuto
    makeSessionBackend _ = do
        backend <- defaultClientSessionBackend 1 "keyfile.aes"
        return $ Just backend
{-
    defaultLayout widget = do
        pc <- widgetToPageContent widget
        mmsg <- getMessage
        withUrlRenderer
            [hamlet|
                $doctype 5
                <html>
                    <head>
                        <title>#{pageTitle pc}
                        ^{pageHead pc}
                    <body>
                        $maybe msg <- mmsg
                            <p>Your message was: #{msg}
                        ^{pageBody pc}
            |]
-}        
    
{-
 makeSessionBackend _ =
        fmap Just $ defaultClientSessionBackend minutes filepath
      where minutes = 24 * 60 -- 1 dia
            filepath = "mykey.aes"
-}

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

-- sinonimo para o tipo do applicative form
type Form a = Html -> MForm Handler (FormResult a, Widget)