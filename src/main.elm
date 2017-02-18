-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/web_sockets.html


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


echoServer : String
echoServer =
    "ws://localhost:8000"



-- MODEL


type alias Model =
    { input : String
    , messages : List String
    , action : String
    , prompt : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [] "Join" "Enter your name to join", Cmd.none )



-- UPDATE


type Msg
    = Input String
    | Send
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg { input, messages, action, prompt } =
    case msg of
        Input newInput ->
            ( Model newInput messages action prompt, Cmd.none )

        Send ->
            ( Model "" messages "Send" "Type a message to chat", WebSocket.send echoServer input )

        NewMessage str ->
            ( Model input (str :: messages) action prompt, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen echoServer NewMessage



-- VIEW


view : Model -> Html Msg
view { input, messages, action, prompt } =
    div []
        [ div [] (List.map viewMessage (List.reverse messages))
        , Html.input [ onInput Input, value input, placeholder prompt ] []
        , button [ onClick Send ] [ text action ]
        ]


viewMessage : String -> Html msg
viewMessage msg =
    p [] [ text msg ]
