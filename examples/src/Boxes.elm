module Boxes exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import DragAndDropEvents exposing (..)


-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL
-- Ideally, the dragged value would be set at "dragtime" through the
-- dataTransfer object. Unfortunately Html.Events does not yet support it,
-- hence this "dragged" workaround.


type alias Model =
    { dragged : String
    , events : List String
    }


init : ( Model, Cmd Msg )
init =
    ( initial, Cmd.none )


initial : Model
initial =
    Model "" [ "Nothing happened yet" ]



-- UPDATE


type Msg
    = DragStart String
    | Drop String
    | DragEnter String
    | DragLeave String
    | DragOver
    | DragEnd String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "got msg" msg of
        DragStart box ->
            let
                events' =
                    ("Started dragging box " ++ box) :: model.events

                model' =
                    { model | dragged = box, events = events' }
            in
                ( model', Cmd.none )

        Drop box ->
            let
                events' =
                    ("Box " ++ model.dragged ++ " dropped on box " ++ box) :: model.events

                model' =
                    { model | dragged = "", events = events' }
            in
                ( model', Cmd.none )

        DragEnter box ->
            let
                events' =
                    ("Dragging entered box " ++ box) :: model.events

                model' =
                    { model | events = events' }
            in
                ( model', Cmd.none )

        DragLeave box ->
            let
                events' =
                    ("Dragging left box " ++ box) :: model.events

                model' =
                    { model | events = events' }
            in
                ( model', Cmd.none )

        -- This is only defined to make dropping work
        -- Logging this would be quite spammy as it registers every frame
        -- when the draggable is over a droppable.
        DragOver ->
            ( model, Cmd.none )

        DragEnd box ->
            let
                events' =
                    ("Stopped dragging box " ++ box) :: model.events

                model' =
                    { model | events = events' }
            in
                ( model', Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div
            [ draggable "true"
            , class "box green"
            , onDragStart (DragStart "1")
            , onDrop (Drop "1")
            , onDragEnter (DragEnter "1")
            , onDragLeave (DragLeave "1")
            , onDragEnd (DragEnd "1")
            , onDragOver DragOver
            ]
            [ text "box 1" ]
        , div
            [ draggable "true"
            , class "box yellow"
            , onDragStart (DragStart "2")
            , onDrop (Drop "2")
            , onDragEnter (DragEnter "2")
            , onDragEnd (DragEnd "2")
            , onDragLeave (DragLeave "2")
            , onDragOver DragOver
            ]
            [ text "box 2" ]
        , div
            []
            (List.map printEvent (List.reverse model.events))
        ]


printEvent : String -> Html a
printEvent event =
    div [] [ text event ]
