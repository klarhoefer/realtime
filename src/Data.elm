module Data exposing (loadData, DataError, errorMessage, Samples)


import Http
import Json.Decode as D


type alias DataError = Http.Error

type alias Samples =
    { second: Int
    , samples: List Float
    }


loadData : (Result Http.Error Samples -> msg) -> Cmd msg
loadData msg =
    Http.get
        { url = "/data"
        , expect = Http.expectJson msg
            (D.map2 Samples
                (D.field "second" D.int)
                (D.field "samples" (D.list D.float))
            )
        }


errorMessage : DataError -> String
errorMessage de =
    case de of
        Http.BadBody badBody -> badBody
        _ -> "Error"
