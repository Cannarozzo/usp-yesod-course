{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Admin where

import Foundation
import Yesod.Core

getAdminR :: Handler Html
getAdminR = defaultLayout
    [whamlet|
        <p>voce eh admin!
        <p>
            <a href=@{HomeAuthR}>
                Retornar a pagina home
    |]