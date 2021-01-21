{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application where

import Foundation
import Yesod.Core
import Yesod.Auth

import Handler.Add
import Home
import Handler.Pagina1
import Handler.Pagina2
import Handler.InputForm
import Handler.AppliForm
import Handler.Sessao
import Handler.SetMessage

import Handler.Admin
import Handler.HomeAuth

mkYesodDispatch "App" resourcesApp

