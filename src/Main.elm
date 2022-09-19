module Main exposing (..)


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Time

import Data exposing (..)
import Graph exposing (..)


type Msg
    = GotSamples (Result DataError Samples)
    | Tick Time.Posix


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
subscriptions _ =
    Time.every 1000 Tick


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick _ -> (model, loadData GotSamples)
        GotSamples samplesRes ->
            case samplesRes of
                Ok samples -> ({model | samples = samples.samples
                                      , second = samples.second
                                      , errMsg = Nothing }
                              , Cmd.none
                              )
                Err err -> ({model | errMsg = Just (errorMessage err)}, Cmd.none)


view : Model -> Html Msg
view model =
    div []
        [ text <| "Second " ++ (String.fromInt model.second)
        , div []
            [ div []
                [ drawSamples model.samples
                ]
            , div []
                (case model.errMsg of
                    Just errMsg -> [ text errMsg ]
                    _ -> []
                )
            ]
        ]
