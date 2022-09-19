module Graph exposing (drawSamples)


import Svg exposing (..)
import Svg.Attributes exposing (..)


drawSamples : List Float -> Svg msg
drawSamples samples =
    let
        pnts = List.indexedMap Tuple.pair samples
             |> List.map (\(a, b) -> (String.fromInt a) ++ "," ++ (String.fromFloat (100.0 * b)))
             |> String.join " "
    in
        svg []
            [ polyline [ points pnts, fill "none", stroke "blue" ]
                []
            ]