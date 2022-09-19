module Data exposing (loadData)


import Http
import Json.Decode as D


loadData : (Result Http.Error (List Float) -> msg) -> Cmd msg
loadData msg =
    Http.get
        { url = "/data"
        , expect = Http.expectJson msg (D.list D.float)
        }

-- samplesDecoder : D.Decoder (List Float)
-- samplesDecoder = D.list D.float
