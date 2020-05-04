module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)


type alias Model =
    { field : String
    , uid : Int
    , todos : List Todo
    }


type alias Todo =
    { id : Int
    , name : String
    , isComplete: Bool
    }

type Msg
    = AddTodo
    | SetField String
    | DeleteTodo Int
    | CompleteTodo Int Bool


initialModel : Model
initialModel =
    { field = ""
    , uid = 0
    , todos = []
    }

view : Model -> Html Msg
view model =
    div [ class "text-center" ] [ div [ class "todo-container text-left p-24 bg-white shadow-sm rounded flex flex-col mx-auto my-48" ]
        [ header [ ]
            [ h1 [ class "text-24 font-bold mb-24" ] [ text "Todo List" ]
            ]
        , Html.form [ class "w-full flex justify-between" ,onSubmit AddTodo ] [
            input
                [ class "todo-input"
                , onInput
                    (\string -> SetField string)
                , value model.field
                ]
                []
            , button [ class "btn", type_ "submit", disabled (model.field == "") ] [ text "Create" ]
        ]
        , ul [ class "text-left mt-24" ] (List.map viewSearchResult model.todos)
    ]
    , a [ class "mt-48 text-12 text-gray-800", href "https://github.com/elisealcala/elm-todo-app" ] [ text "Github" ]
    ]


viewSearchResult : Todo -> Html Msg
viewSearchResult todo =
    li [ class "border-b border-gray-200 py-8 flex justify-between", onClick (CompleteTodo todo.id todo.isComplete) ]
        [ span [ classList[("completed", todo.isComplete)], class "text-todo" ] [ text todo.name ]
        , button
            [ class "text-gray-800 outline-none", onClick (DeleteTodo todo.id)]
            [ text "X" ]
        ]

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodo ->
            { model | todos = { id = model.uid, name = model.field, isComplete = False } :: model.todos, field = "", uid = model.uid + 1 }
        SetField str ->
            { model | field = str }
        DeleteTodo id ->
            { model | todos = List.filter(\todo -> todo.id /= id) model.todos }
        CompleteTodo id complete ->
            let
                updateTodo todo =
                    if todo.id == id then
                        { todo | isComplete = not complete }
                    else
                        todo
            in
            { model | todos = List.map updateTodo model.todos }



main : Program () Model Msg
main =
    Browser.sandbox
        { view = view
        , update = update
        , init = initialModel
        }