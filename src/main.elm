port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket exposing (listen)
import List exposing (reverse)
import Json.Decode as Json


-- PROGRAM


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- PORTS


port getport : String -> Cmd msg


port portreply : (String -> msg) -> Sub msg



-- MODEL


type alias Model =
    { input : String
    , messages : List String
    , action : String
    , prompt : String
    , windowstyle : String
    , echoserver : String
    }


model =
    { input = ""
    , messages = []
    , action = "Join"
    , prompt = "Enter your name to join"
    , windowstyle = "start"
    , echoserver = ""
    }


init : ( Model, Cmd Msg )
init =
    ( model, getport "PORTREQUIRED" )



-- UPDATE


type Msg
    = Socketport String
    | KeyDown Int
    | Input String
    | Send
    | NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Socketport socketport ->
            ( { model | echoserver = socketport }, Cmd.none )

        Input newInput ->
            ( { model | input = newInput }, Cmd.none )

        KeyDown key ->
            if key == 13 then
                ( { model | input = "" }
                , WebSocket.send model.echoserver model.input
                )
            else
                ( model, Cmd.none )

        Send ->
            ( { model | input = "" }
            , WebSocket.send model.echoserver model.input
            )

        NewMessage str ->
            ( { model
                | messages = (str :: model.messages)
                , action = "Send"
                , prompt = "Type a message to chat"
                , windowstyle = "joined"
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ listen model.echoserver NewMessage
        , portreply Socketport
        ]



-- VIEW


view : Model -> Html Msg
view { input, windowstyle, messages, action, prompt } =
    div [ class windowstyle ]
        [ div [ class "component" ]
            [ div [ class "output" ] (List.map viewMessage (reverse messages))
            , div [ class "controls" ]
                [ Html.input
                    [ onInput Input
                    , onKeyDown KeyDown
                    , value input
                    , placeholder prompt
                    , class "input"
                    ]
                    []
                , button
                    [ onClick Send
                    , class "submit"
                    ]
                    [ text action ]
                ]
            ]
        ]


viewMessage : String -> Html msg
viewMessage msg =
    p [] [ text msg ]


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)
