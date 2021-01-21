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
import Network.HTTP.Conduit (Manager)
import Yesod.Auth
import Yesod.Auth.Dummy -- just for testing, don't use in real life!!!


data App = App
    { httpManager :: Manager}

mkYesodData "App" $(parseRoutesFile "routes.yesodroutes")

instance Yesod App where -- Sessao setada para 1 minuto
    makeSessionBackend _ = do
        backend <- defaultClientSessionBackend 1 "keyfile.aes"
        return $ Just backend
    authRoute _ = Just $ AuthR LoginR

    -- route name, then a boolean indicating if it's a write request
    isAuthorized HomeR True = isAdmin
    isAuthorized AdminR _ = isAdmin

    -- anyone can access other pages
    isAuthorized _ _ = return Authorized
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

isAdmin = do
    mu <- maybeAuthId
    return $ case mu of
        Nothing -> AuthenticationRequired
        Just "admin" -> Authorized
        Just _ -> Unauthorized "You must be an admin"

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

-- sinonimo para o tipo do applicative form
type Form a = Html -> MForm Handler (FormResult a, Widget)

instance YesodAuth App where
    type AuthId App = Text
    authenticate = return . Authenticated . credsIdent

    loginDest _ = HomeR
    logoutDest _ = HomeR

    authPlugins _ = [authDummy]

    maybeAuthId = lookupSession "_ID"