port module Ports exposing (..)

-- port for sending strings out to JavaScript


port getport : String -> Cmd msg



-- port for listening for suggestions from JavaScript


port portreply : (String -> msg) -> Sub msg
