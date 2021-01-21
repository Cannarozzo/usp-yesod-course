{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application where

import Foundation
import Yesod.Core

import Add
import Home
import Pagina1
import Pagina2
import InputForm
import AppliForm
import Sessao
import SetMessage


mkYesodDispatch "App" resourcesApp

