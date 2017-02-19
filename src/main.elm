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
    , windowstyle : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [] "Join" "Enter your name to join" "start", Cmd.none )



-- UPDATE


type Msg
    = Input String
    | Send
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg { input, messages, action, prompt, windowstyle } =
    case msg of
        Input newInput ->
            ( Model newInput messages action prompt windowstyle, Cmd.none )

        Send ->
            ( Model "" messages "Send" "Type a message to chat" "joined", WebSocket.send echoServer input )

        NewMessage str ->
            ( Model input (str :: messages) action prompt windowstyle, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen echoServer NewMessage



-- VIEW


view : Model -> Html Msg
view { input, windowstyle, messages, action, prompt } =
    div [ class windowstyle ]
        [ div [ class "component" ]
            [ div [ class "output" ] (List.map viewMessage (List.reverse messages))
            , div [ class "controls" ]
                [ Html.input [ onInput Input, value input, placeholder prompt, class "input" ] []
                , button [ onClick Send, class "submit" ] [ text action ]
                ]
            ]
        ]


viewMessage : String -> Html msg
viewMessage msg =
    p [] [ text msg ]
