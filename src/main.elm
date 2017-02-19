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


model =
    { input = ""
    , messages = []
    , action = "Join"
    , prompt = "Enter your name to join"
    , windowstyle = "start"
    }


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )



-- UPDATE


type Msg
    = Input String
    | Send
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newInput ->
            ( { model | input = newInput }, Cmd.none )

        Send ->
            ( { model | input = "", action = "Send", prompt = "Type a message to chat", windowstyle = "joined" }, WebSocket.send echoServer model.input )

        NewMessage str ->
            ( { model | messages = (str :: model.messages) }, Cmd.none )



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
