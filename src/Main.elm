module Main exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Http

import Data exposing (..)

type Msg
    = GotSamples (Result Http.Error (List Float))


type alias Model =
    { second: Int
    , samples: List Float
    , errMsg: Maybe String
    }


main : Program () Model Msg
main = Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }


init : () -> (Model, Cmd Msg)
init _ = (Model 0 [] Nothing, loadData GotSamples)


subscriptions : model -> Sub Msg
subscriptions _ = Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotSamples samplesRes ->
            case samplesRes of
                Ok samples -> ({model | samples = samples }, Cmd.none)
                Err _ -> ({model | errMsg = Just "Mist!"}, Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [ text <| "Second " ++ (String.fromInt model.second)
        , a [ href "/data" ]
            [ text "data" ]
        , div []
            [ div []
                (List.map viewSample model.samples)
            ]
        ]

viewSample : Float -> Html Msg
viewSample f =
    span []
        [ text (String.fromFloat f)
        ]
