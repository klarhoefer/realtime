module Main exposing (..)


import Browser
import Html exposing (..)


type Msg
    = Noop


type alias Model =
    { second: Int
    }

main : Program () Model Msg
main = Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }


init : () -> (Model, Cmd Msg)
init _ = (Model 0, Cmd.none)


subscriptions : model -> Sub Msg
subscriptions _ = Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Noop -> (model, Cmd.none)


view : Model -> Html Msg
view model =
    div []
        [ text (String.fromInt model.second) ]
