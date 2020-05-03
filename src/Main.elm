module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Random exposing (int)

type alias Model =
    { query : String
    , todos : List Todo
    }


type alias Todo =
    { id : Int
    , name : String
    }

type Msg
    = AddTodo
    | SetQuery String
    | DeleteTodo Int


initialModel : Model
initialModel =
    { query = ""
    , todos = []
    }

view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ header [ class "bg-red-100" ]
            [ h1 [] [ text "New Todo App build with Elm" ]
            , span [ class "tagline" ] [ text "Like GitHub, but for Elm things." ]
            ]
        , input
            [ class "search-query"
            , onInput
                (\string -> SetQuery string)
            , value model.query
            ]
            []
        , button [ class "search-button", onClick AddTodo ] [ text "Add Todo" ]
        , ul [ class "results" ] (List.map viewSearchResult model.todos)
        ]


viewSearchResult : Todo -> Html Msg
viewSearchResult todo =
    li []
        [ span [ class "star-count" ] [ text todo.name ]
        , button
            [ class "hide-result", onClick (DeleteTodo todo.id)]
            [ text "X" ]
        ]

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodo ->
            { model | todos = { id= 0, name= model.query } :: model.todos, query = "" }
        SetQuery str ->
            { model | query = str }
        DeleteTodo id ->
            { model | todos = List.filter(\todo -> todo.id /= id) model.todos }


main : Program () Model Msg
main =
    Browser.sandbox
        { view = view
        , update = update
        , init = initialModel
        }