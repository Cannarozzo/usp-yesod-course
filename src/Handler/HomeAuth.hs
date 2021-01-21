{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.HomeAuth where

import Foundation
import Yesod.Core
import Yesod
import Yesod.Auth


getHomeAuthR :: Handler Html
getHomeAuthR = do
    maid <- maybeAuthId
    defaultLayout
        [whamlet|
            <p>Observacao: Logue como "admin" para ser um administrador.
            <p>Seu atual auth ID: #{show maid}
            $maybe _ <- maid
                <p>
                    <a href=@{AuthR LogoutR}>Logout
            <p>
                <a href=@{AdminR}>Ir para a página de Admin
            <form method=post>
               Faça uma alteração (apenas administradores)
                \ #
                <input type=submit>
        |]

postHomeAuthR :: Handler Html
postHomeAuthR = do
    setMessage "Voce fez alguma alteracao na página"
    redirect HomeR