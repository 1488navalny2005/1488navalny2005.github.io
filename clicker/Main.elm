module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)

main = beginnerProgram { model = gameState, view = view, update = update }

gameState : { level : Int, count : Int }
gameState = { level = 1, count = 0 }

nextLevel model = case model.level of
                      1 -> Just 100
                      2 -> Just 500
                      3 -> Just 1000
                      4 -> Just 5000
                      5 -> Just 15000
                      6 -> Just (10 ^ 10 ^ 10) -- ибо нехуй      > 10 ^ 10 ^ 10
                      _ -> Nothing             --                  Infinity : number
                      

--                             vvvvvvvvvvvvvvvvvvvvvvvv - Хуита (но это не точно)                    
showButton model =
    h1 [hidden (model.count < (updateLevel model).costs), onClick Upgrade] [text "Upgrade"]

view model =
  div [style [("text-align", "center")]]
    [
     h1 [] [text (toString model.count)],
     h2 [] [text ("Level: " ++ (toString model.level))],
     img [src "boku.jpg", onClick Increment] [],
     h1 [] [text "Накачай Яндолу"],
     showButton model
    ]

type Msg = Increment | Upgrade

updateLevel model =
    case nextLevel model of
        Just n ->  { notLastLevel = True, costs = n }
        Nothing -> { notLastLevel = False, costs = 0 }

incByLevel model =
    case model.level of
        1 -> 1
        2 -> 5
        3 -> 10
        4 -> 15
        5 -> 1488
        _ -> 42 -- ХЗ
    
update msg model =
  case msg of
    Increment ->
      { model | count = model.count + incByLevel model }
    Upgrade ->
      let up = updateLevel model in
      if up.notLastLevel then
         { model | level = model.level + 1, count = model.count - up.costs} 
      else
         model 
