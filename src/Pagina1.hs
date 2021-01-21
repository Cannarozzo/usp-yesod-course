{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Pagina1 where

import Foundation
import Yesod.Core

getPagina1R :: Handler Html
getPagina1R = defaultLayout $ do
    setTitle "Titulo da página"
    toWidget [lucius| h1 { color: green; } |]
    addScriptRemote "https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"
    toWidget
        [julius|
            $(function() {
                $("h1").click(function(){
                    alert("Voce clicou no cabecalho!");
                });
            });
        |]
    toWidgetHead
        [hamlet|
            <meta name=keywords content="meta informacao da tag head">
        |]
    toWidget
        [hamlet|
            <h1> Forma de usar o hamlet com a funcao toWidget
        |]
    [whamlet|<h2>Forma do hamlet com widget |]
    toWidgetBody
        [julius|
            alert("Adiciona o javascript no dentro da tag body");
        |]