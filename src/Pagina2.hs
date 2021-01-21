{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Pagina2 where

import Foundation
import Yesod.Core
import Data.Text



data Pessoa = Pessoa {nome:: Text , idade::Int } | Nulo deriving Show

pessoas = [Pessoa "Patrick" 24, Pessoa "Felipe" 34, Pessoa "Fulano" 55]

ehPessoa :: Pessoa -> Maybe Pessoa
ehPessoa (Pessoa n i) = Just (Pessoa n i)
ehPessoa Nulo = Nothing

getPagina2R :: Handler Html
getPagina2R = defaultLayout $ do
    let autorizado = False
    let mpessoa = ehPessoa (Pessoa "Patrick" 24) 
    [whamlet| 
      $if autorizado
        Voce foi atorizado
      $else
        Acesso negado
      <br>
      $maybe Pessoa nome idade <- ehPessoa (Pessoa "Felipe" 34)
        <p>
          Seu nome é #{nome} e a sua idade é: #{pack $ show $ idade}
      $nothing
         <p>
            Pessoa inexiste
      <br>
        $if Prelude.null pessoas
          <p>
            Não há pessoas
        $else
          <ul>
            $forall pessoa <- pessoas
              <li>
                #{nome pessoa}
                
      <br>
      
      $case mpessoa 
        $of Just pessoa
          <p>
            #{show pessoa}
        $of Nothing
          <p>
            pessoa inválida
 
 
    |]
    
    [whamlet|
        <form action=@{InputFormR}>
            <p>
                Nome
                <input type=text name=nome>
                Idade
                <input type=text name=idade>
                <input type=submit value="Enviar">
    |]